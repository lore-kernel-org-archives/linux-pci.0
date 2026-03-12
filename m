Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761C377ECC
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320585; cv=none; b=HE6Z1xcCmzHoqdfl3Ob2wQdZMvIxTk65EO//LlWFcLaZwKCgm5VMS8kUAqeU5yJeIofxq4nTW+IPXPCB7W5BNiy0M0Ah9D+GqzHp2ukCRifRDKLnqIvB2uSW05oEZiNbUQ4bCCq0OegcU543NZbnnk1vK6bZK+FV5VJkYdX9S8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320585; c=relaxed/simple;
	bh=OqWo89AB+av7r7z/Jj/i8hdeIyEnnPEkq7fXFX8Ehdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4DiQzsX8EVPLH+F0WrTmqootDYAr0+TXfpmC5xb7V1Ha68avLLd89M6sHkppM0UX7WklZLv8OK0J9wAwE7ihhUsPZ5tOd0aArYTxc6jl/IW6aadyTw0oCfhSiWGrrhvE75iRUyI8qUBvWqF6oUSqq00AdmL5iyQ8/zZ6lAP0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikfMq9JW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikfMq9JW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA65DC4CEF7;
	Thu, 12 Mar 2026 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320585;
	bh=OqWo89AB+av7r7z/Jj/i8hdeIyEnnPEkq7fXFX8Ehdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikfMq9JW67FP9OIB1EhlAlXYT0Ner/uCmoqotG3sXGD4lODerbpFMAxUQwypuusdR
	 li9Cvk23rfMbI/AY3habb8Q21/H1B/ovJVD7XceSb/bIjYoa7g9F3cdwXJ/CCJHKyS
	 fDK97KckW9R9APvdWliwFqd4sZij/DttC7dy5oRkSyTXwuhHcJQt4fbz62ybks7JYl
	 31Fx3ZitYn1POT+g7+NTJMKbJnnzRGnJfWazBiw9+2UfrokvMAC+RFHuVDjebWR8Tl
	 qcyyovmy/1iWSkP1RnZPKN/47ce4oFoGf2AVfDbBzMYinQwO4e8sl4pipIoakFzNki
	 Ec3UFA8nontfA==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 02/10] PCI: endpoint: Allow only_64bit on BAR_RESERVED
Date: Thu, 12 Mar 2026 14:02:30 +0100
Message-ID: <20260312130229.2282001-14-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312130229.2282001-12-cassel@kernel.org>
References: <20260312130229.2282001-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=cassel@kernel.org; h=from:subject; bh=kVFPg9HKQByOyf33a6/BSixKHTnhEXfHzDCSboyyoJE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI37cy+18LPfKbkmwPXE4PbZfu+tzBYSB36KaDPfa3h9 4lsp8KOjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkXxPDH37ehv3Rxv0OobJq 2+x6UrsVFn/+4TU36wZHZ3Drd7797xgZHsgHzWo7myUk8evF1cI7QhfCNVa+aF22r+ce90nuzUv 7eAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Remove the documentation that forbids setting only_64bit on a BAR of type
BAR_RESERVED.

When a reserved BAR is 64-bit by default, setting only_64bit is the most
accurate description. If we later add support to disable a reserved BAR
(e.g. disable_bar() for BARs that were never set via set_bar()), the
implementation will need to clear the adjacent BAR (upper 32 bits) as well;
having only_64bit set documents that requirement.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/linux/pci-epc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c981ea7d52c0..5c59f5606869 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -207,11 +207,6 @@ enum pci_epc_bar_type {
  * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
  *		should be configured as 32-bit or 64-bit, the EPF driver must
  *		configure this BAR as 64-bit.
- *
- *		only_64bit should not be set on a BAR of type BAR_RESERVED.
- *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
- *		touch, then both BARx and BARx+1 must be set to type
- *		BAR_RESERVED.)
  */
 struct pci_epc_bar_desc {
 	enum pci_epc_bar_type type;
-- 
2.53.0

