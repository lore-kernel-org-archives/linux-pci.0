Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438791;
	b=BKaEwNDMOtrc6JJnGnph1a5jjcSkdlTXGtgMsW1o5V2Rwx5b1YxIg2blBatN9ifFyhuj
	 4U6fXSUMXks69WFqWfSl5CB4rsKyrLWK0hu0/3r4T0TgavibBAfpl5JpWMlHb0XBt2s4+
	 2CBoJkPNQ2M7ykHL/C20DD03ROflzxpYxF8Wfo1PhgAzXvmh2HpwLNi2eIJyj4LHWaU61
	 hUQHF0GlcWp2n+t7Pi29uc/K8boo1uIBatIMt+/uJeolSRfUyjrMaUPbDhzLCn0XYvTkK
	 KMo41RxDEVCPnjNW25W7oHAyJetH/ERbaU7dyJ0bI+6kbENHnFQnxbsyTKwHsEMU6EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=f9As8HBV5BZHZYm6lpYm49k82uMEiXsgF0b4Qe9Y/VA=;
	b=LTvojNcQABA3DkNK7NwIaFTXGOEYD9fX3jv9IYVq9SwO1HAWQqPs9Fke9OB302JQs1bc
	 78mTLcQjFF3YgyS+5BtBbvvJOQtKVW4TrkQN2MnX84l0KvLltobhpztMSrgstIUqV85SC
	 WceTXvrwzZbLMuq4E2rVHYIF8XiEgLOYuWAWMWU2Y1SxR1VqvQK0+ZbSXGteFD+3YWTqw
	 MBIYNRU6Biv/h/r6GPiywgxFWHN9LlauNeqHtdWAMXY/QdtP8Xo5OzMZoN0/Tjpw//g2T
	 HqGotvXzXTrxwmTrgNLJb4qJDsNYJ4ql/3C29nNEqTcfdPJYMv8JfPS8RV3GciQ3bnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgQiZpCB;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009AE606A31E
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 12:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgQiZpCB
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f01f296937so25444005ad.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438790; x=1796043590; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9As8HBV5BZHZYm6lpYm49k82uMEiXsgF0b4Qe9Y/VA=;
        b=CgQiZpCBqqWE/2A1tGiNCfkWOmweFKUZv8q6+dWW11selayAQEe8YnbZXzZy05Idn6
         ryFqVhh4FfwaNmruDL22+Rhn/4EzKzcSYm2in8IfcE9rueaNdeJUfZafNjriW2oUiTkj
         cZhRi2d9e340Y5IDub4ZpHpfv9nd9oJCnHgnC8Z4vLkG3IvPxJupXC70e4aLpvtjaZlf
         PH5VbWhGgeYfNs8HHXEJlkl9IK8rbaF8urn170scC61CQ8KFQ2NQdNb3BnDgamnIiS3a
         /jYR8XMuuM7Cm2R4gTQnLLaEQWaUBRgTsAklnRdBE/DY7ipdPm0FvpmAYYwRi2xs1pSt
         ozuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438790; x=1796043590;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f9As8HBV5BZHZYm6lpYm49k82uMEiXsgF0b4Qe9Y/VA=;
        b=eSuVcOWM9YdjIHJjNGysec4P24DwKKcYRrpMoF3z3QzDmZvQMN7uyTqQc1js5wvrYs
         E+rSEDZDjp/US7eIbzQwrDUBEEBvlFYI4QmduU7LFl0R5ssEN+A2nWQxkJj5GgrJm8Ce
         4jdPcOJBRxA21AqcTpPMxpQFoiwDJkREMNDHSv8sHIJndm78o3XdPGTE6XkOH6bwXG9b
         uQDwqlTvliVQdA2NRFG+1z6/Wc77jYnGrdH+Mm8hT3yRwonLXvTLr8B2AtDEgFc94SSE
         TmKytFfFXS6pWmVpSPZRdmazI0fvLmeKmWzSZtfgUaETYxVh2GhdmOAtBfyIMCGxbYs8
         cZPA==
X-Gm-Message-State: APuU4Z+XH6adRsBrcOF/kfaG1vZBhVqu+ABJ47oJaHtkNIsnftmlZMCc
	vC3tbFEdPvQ0q2i1YCvjsbRtUMAyIjCaTH18otdYdE8o1M3Eb97Y/VTO0EFANA==
X-Gm-Gg: AZFdTZfbGiNMQ+GO4nqbsURQQtVWw/hY9xCiG4emnBvI9UTpCn7vY7L5/NYo3LNGt9k
	EkyJJvSv8obJuDejTykhL/UIQef/FCPSB+9Z8Yr7ASUXM3dl5LknWRkSx2x+JnG+fRe/rm8QiTm
	JMY2+3udEkSJ6sPFtYE5RQI9oj8NgJSDnYzDj7UzzjE/8fj9NTZl/dUEQTjtQvTqqYaP2huCPev
	2oAtQNUoY98GLC1OPz9CMyzMH0O2h539etaAABpdbdBbPEG4XFI7oGDnLaC9Y3l+lXcpDbDXB/6
	uI033vWIsdXPZFxJQyKmAa/byd+BIRDeja/HdaWoqW/xIVf6Jq4m8TgmDyBNlVnlVcY3qZ/Ampi
	H3oIBa0dI2mfuo6o3luawTqL+49ivr01+2+0LmkTrTv+9KQaFRRUgD4BfY72A6bnWq0pgNGZS/F
	VnqT9ftFQ1MlP33dEwAZ861fht0NVM38wFgpgiot8sx2a4oQz1yKeOetuse3s2cv9jQPe84ZEGJ
	6vmjScZ4Rig+jAYWKLKVr6ToA2NzTFtLqAdn9tOQYyuE2lv65w1iIZIiyDVw3GfswqU36UK5Hfg
	ffkwVp8T8gy4exaz6jELZDXevAgHqsEiH58YquhDXhuziT42Oq2b21HnKQvEgkCE/8kQ1mzxPCC
	yR7OryRAj8t2oXqO/Ap3nnw==
X-Received: by 2002:a17:90b:3fc5:b0:3ac:a521:959 with SMTP id 98e67ed59e1d1-3b41c900ea0mr9730144a91.29.1795438790205;
        Mon, 23 Nov 2026 04:59:50 -0800 (PST)
Received: from [192.168.137.1] ([61.141.183.102])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea770asm5251041a12.3.2026.11.23.04.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:59:49 -0800 (PST)
From: Chen Haohui <hhc436476@gmail.com>
To: linux-pci <linux-pci@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject:
 [PATCH] PCI: Restore the device allowlist for lifting the 2.5GT/s speed clamp
Date: Mon, 23 Nov 2026 20:59:42 +0800
Message-ID: <179543878283.1348.10115969159184460350@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link
retraining") removed the Vendor:Device allowlist and the link status check
gating the removal of a 2.5GT/s speed restriction, so the restriction is now
lifted on any downstream port that supports a faster link and whose Target
Link Speed reads 2.5GT/s.  The commit message says this is done "in a hope
it is safe to do so".

On a Fujitsu XH320 V2 it is not.  Root port 00:1c.3 is a 5GT/s capable
C600/X79 PCH port, and firmware brought its link up at 2.5GT/s with Target
Link Speed clamped to match.  Behind it is an XGI Z11/Z11M VGA adapter
(07:00.0) whose own Link Capabilities advertise 2.5GT/s only.  Lifting the
restriction makes the port retrain at 5GT/s, which does not complete against
an endpoint that only advertises 2.5GT/s, and the endpoint is dropped:

  pci 0000:00:1c.3: removing 2.5GT/s downstream link speed restriction
  ...
  (no 0000:07:00.0 line follows; 18ca:0027 is absent and there is one PCI
   device fewer than with the restriction left in place)

The existing failure path never runs.  pcie_retrain_link(dev, false) samples
DLLLA right after setting Retrain Link, while DLLLA still holds its
pre-retrain value of 1, so it reports success immediately.  I measured the
window on this machine by issuing the same register writes from user space:
DLLLA reads 1 at t=3D0 and drops at t=3D24.9ms.  Hence "retraining failed" is
never printed, Target Link Speed stays at 5GT/s, and the endpoint stays off
the bus.

Rolling back afterwards does not recover the device, so that is not an
alternative.  Writing Target Link Speed back to 2.5GT/s in the same
millisecond DLLLA drops -- the best timing any post-failure workaround can
achieve -- does bring the link and the endpoint back (18ca:0027 enumerates,
Target Link Speed 2.5GT/s), but the device has been reset: PCI Command reads
0, CRTC Mode Control loses bit 7, and the display stops scanning.  That is a
dead local console, and no software brings it back: unbinding and rebinding
vgacon, restoring Command to 0x0007, none of it helps.  Only the firmware
mode set after a reboot does.

So for this class of device the restriction must not be lifted at all.
Whether the lift can succeed depends on the device behind the port, and when
this quirk runs -- from pci_setup_device(), before the bus behind the port
has been scanned -- that device is not enumerated yet.  That is why the
allowlist was there in the first place.

Restore it.  Moving the restriction removal to a point after the subordinate
bus has been enumerated, and consulting the downstream devices' Link
Capabilities there, would keep the hot-plug case working; I am willing to do
that as a follow-up, but it is a larger change, and this regression takes
machines that only have a local console off the air, so it should not wait
for it.

Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed lin=
k retraining")
Cc: stable@vger.kernel.org	# v6.5+
Link: https://lore.kernel.org/all/179499032167.260.12060379483856337575@gmail=
.com/
Reported-by: Chen Haohui <hhc436476@gmail.com>
Signed-off-by: Chen Haohui <hhc436476@gmail.com>
---
Tested on the affected machine (Fujitsu XH320 V2, C600/X79 PCH, XGI
Z11/Z11M VGA), v7.3.4 with this patch on top, using the Ubuntu mainline
7.3.4 .config with only DEBUG_INFO turned off:

  v7.3.4, unpatched:  78 PCI devices, 18ca:0027 absent, Target Link Speed
                      left at 5GT/s, local console dead
  v7.3.4 + this patch: 79 PCI devices, 18ca:0027 present, Target Link Speed
                      2.5GT/s, "removing 2.5GT/s..." no longer printed,
                      simpledrm binds fb0 and the console works
  6.8.0-31:            79 PCI devices, 18ca:0027 present, same as above

The same numbers come out of the unpatched kernel when the single offending
register write is issued by hand from user space on 6.8.0-31, i.e. the
difference above is attributable to this one hunk.

 drivers/pci/quirks.c | 20 +++++++++++++-------
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -80,10 +80,15 @@
  * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
  * request a retrain and check the result.
  *
- * If this turns out successful, or where a 2.5GT/s speed restriction has
- * been previously arranged by the firmware and the port reports its link
- * already being up, lift the restriction, in a hope it is safe to do so,
- * letting the devices negotiate a higher speed.
+ * If this turns out successful and the device is one where lifting the
+ * restriction is known to be safe, then lift it and let the devices
+ * negotiate a higher speed.
+ *
+ * Do not lift the restriction on a link that firmware has already brought
+ * up at 2.5GT/s merely because the port itself could go faster: a retrain
+ * at a speed the device behind the port does not support takes that device
+ * off the bus, and it does not come back.  For a display device this means
+ * a blank local console with no software-recoverable state.
  *
  * Otherwise revert the speed to the original setting and request a retrain
  * again to remove any residual state, ignoring the result as it's supposed
@@ -94,6 +99,10 @@
  */
 int pcie_failed_link_retrain(struct pci_dev *dev)
 {
+	static const struct pci_device_id ids[] =3D {
+		{ PCI_VDEVICE(ASMEDIA, 0x2824) },	/* ASMedia ASM2824 */
+		{}
+	};
 	u16 lnksta, lnkctl2, oldlnkctl2;
 	enum pci_bus_speed speed_cap;
 	int ret =3D -ENOTTY;
@@ -120,7 +129,8 @@
 	}
=20
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
-	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT) {
+	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT &&
+	    pci_match_id(ids, dev)) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
 		ret =3D pcie_set_target_speed(dev, speed_cap, false);
 		if (ret)

