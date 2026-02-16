Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF1E571
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228388; cv=none; b=IZ7n8+4Basoi11sOZvBQ9jmTjBkwKD6cdjCtuIWps3AR1YFIXC6VpcPi5CyDCSaB5cGydQuomAgEOGvvi2CLgspDIj5/ROxO54DdAIjUzIxfa8mMFZAVdxp4DK4uPJb5wwY/FYtqQYTpjbS2P2ikrrLuuz+VWWE3kFpuxSr4luE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228388; c=relaxed/simple;
	bh=uUl60LE7noz5Hltk7doYVL+Lq1uKtL+qdzMYadvwK0o=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=VgU9/pq3obguAl1dyQARalv/VnNMOFvcxR7TSyh9YpKMxwDaVdWr57GkvP9kOC4EIzViYivIxVFQYybl2/Xa55IvKaLZZ5B8Ck0W+nSwrt1tx8Exy2zxxC1F7b41xiw+/jTMLo9pnoHCKH6g7AKe3wzMWCY5bLDnx1TA6SBMgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 19BEE2C06CAB;
	Mon, 16 Feb 2026 08:46:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0172F3CB21; Mon, 16 Feb 2026 08:46:20 +0100 (CET)
Message-Id: <5c1752d7512eed0f4ea57b84b12d7ee08ca61fc5.1771226659.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 16 Feb 2026 08:46:13 +0100
Subject: [PATCH] PCI/ASPM: Fix pci_clear_and_set_config_dword() usage
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, "Adria Vilanova Martinez" <me@avm99963.com>

When aspm_calc_l12_info() programs the L1 PM Substates Control 1 register
fields Common_Mode_Restore_Time, LTR_L1.2_THRESHOLD_Value and _Scale, it
invokes pci_clear_and_set_config_dword() in an incorrect way:

For the bits to clear it selects those corresponding to the field.  So far
so good.  But for the bits to set it passes a full register value.
pci_clear_and_set_config_dword() performs a boolean OR operation which
sets all bits of that value, not just the ones that were just cleared.

Thus, when setting the LTR_L1.2_THRESHOLD_Value and _Scale on the child of
an ASPM link, aspm_calc_l12_info() also sets the Common_Mode_Restore_Time.
That's a spec violation:  PCIe r7.0 sec 7.8.3.3 says this field is RsvdP
for Upstream Ports.  On Adrià's Pixelbook Eve, Common_Mode_Restore_Time
of the Intel 7265 "Stone Peak" wifi card is zero, yet aspm_calc_l12_info()
does not preserve the zero bits but instead programs the value calculated
for the Root Port into the wifi card.

Likewise, when setting the Common_Mode_Restore_Time on the Root Port,
aspm_calc_l12_info() also changes the LTR_L1.2_THRESHOLD_Value and _Scale
from the initial 163840 nsec to 237568 nsec (due to ORing those fields),
only to reduce it afterwards to 106496 nsec.

Amend all invocations of pci_clear_and_set_config_dword() to only set bits
which are cleared.

Finally, when setting the T_POWER_ON_Value and _Scale on the Root Port and
the wifi card, aspm_calc_l12_info() fails to preserve bits declared RsvdP
and instead overwrites them with zeroes.  Replace pci_write_config_dword()
with pci_clear_and_set_config_dword() to avoid this.

Fixes: aeda9adebab8 ("PCI/ASPM: Configure L1 substate settings")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220705#c22
Tested-by: Adrià Vilanova Martínez <me@avm99963.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.11+
---
Only a "Link" tag, not a "Closes" tag because this patch is just a
byproduct that was created while working on the above-linked bugzilla.
The actual root cause of the bugzilla seems to be an ASPM erratum
of the Sunrise Point PCH which needs to be addressed in coreboot.

 drivers/pci/pcie/aspm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cedea47..a1f2752 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -706,22 +706,29 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	}
 
 	/* Program T_POWER_ON times in both ports */
-	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
-	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2,
+				       PCI_L1SS_CTL2_T_PWR_ON_VALUE |
+				       PCI_L1SS_CTL2_T_PWR_ON_SCALE, ctl2);
+	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL2,
+				       PCI_L1SS_CTL2_T_PWR_ON_VALUE |
+				       PCI_L1SS_CTL2_T_PWR_ON_SCALE, ctl2);
 
 	/* Program Common_Mode_Restore_Time in upstream device */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
+				       PCI_L1SS_CTL1_CM_RESTORE_TIME,
+				       ctl1 & PCI_L1SS_CTL1_CM_RESTORE_TIME);
 
 	/* Program LTR_L1.2_THRESHOLD time in both ports */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-				       ctl1);
+				       ctl1 & (PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+					       PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
 	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-				       ctl1);
+				       ctl1 & (PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+					       PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
 
 	if (pl1_2_enables || cl1_2_enables) {
 		pci_clear_and_set_config_dword(parent,
-- 
2.51.0

