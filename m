Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745509;
	b=OTk9nk6J9wXMc6QXoYqyo64ZJ3/xEpnX9lV75oXuCgV7XK15WdSREcTn5m73PQmHfBqf
	 o01MEGDKPJE8lNVmwcsjXD/K3PbGm8/Q2B9bZJe6ImpRtoWJZcvKeufCnu8G2w1mWUdwF
	 Y3KLJvdzDy3nCudHTf0OeOZp5QkEPOAwDzEZWFBXlrhzNVz6pNRA1leOCN4T6lFoxCG3Y
	 AjxDTBYJQxXbWeyrjkUhUl/tkZ7Btp35QlH+RbR2k+eXe7cZpB+t4m+3KZn2pwDZiOcBE
	 KnzQ6wuFARzV09Bd/zUegBe31Cq8SiQCAfdcJgDoATUd8Ecv8E221/Y/iB9Ax7z5bxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745509;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EMn3BA9oJagyxq8mcdu+WHZ1rzD0S/RwVi1PGt5EwlI=;
	b=lpYKA7AS0p4ltU71ECy09LTXUbz3mOplflsM+tEsjUdRojUEltWzmPyJNdYiGZuMYljq
	 x2CLZRQIjdjBC0AUgW6xpdh8XurQ/ahXix8Lg8iVoIGyVShpYHuuUADbLQ7PL9C7cAsXG
	 0erSQ82IiRHXPhe4wUu7QFI9zNByWJAqbUeoKWdfATbOQEAgvVf1dQnVT3r1mOJ2eqjnf
	 nVBvBGZyDMzUrEDBZ32CDrqBAcTrrW9dUhUcC3mo59BlqV4CQTvcXeUKozufb78ypuwYO
	 LiLi6teGYp9vVqh6Y6cgdF8nEiXOftvXj4q6zOpooTnMzWv2SyEN24HMfT2zV0Y1FNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A415606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 02:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A415606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e1a26798ea0711f19a56ed5b684f684d-20261127
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:36ab5d88-dfa4-41e4-b78b-c9e1908ce5e5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:36ab5d88-dfa4-41e4-b78b-c9e1908ce5e5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:fd2baafc20cd4691563638e9e24484a5,BulkI
	D:26112710114301MNUK4G,BulkQuantity:0,SF:17|19|38|66|78|102|127|153|865|89
	8,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e1a26798ea0711f19a56ed5b684f684d-20261127
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(36.112.179.124)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 398914736; Fri, 27 Nov 2026 10:11:39 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: bhelgaas@google.com,
	mani@kernel.org,
	krishna.chundru@oss.qualcomm.com,
	ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	david.e.box@linux.intel.com,
	vidyas@nvidia.com
Cc: linux-pci@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/3] PCI/ASPM: keep software state and hardware in sync
Date: Fri, 27 Nov 2026 10:11:28 +0800
Message-ID: <20261127021128.147354-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three places where the ASPM core ends up recording one state while the
hardware is in another.  They are independent patches, but all three are
about the same invariant: link->aspm_enabled and the saved LNKCTL must
match what is programmed in the device.

1/3 Only update ASPM and CLKREQ bits in the saved LNKCTL

    pci_update_aspm_saved_state() rebuilt the whole saved LNKCTL from a
    value read back from hardware.  When that read failed, or returned
    PCI_ERROR_RESPONSE, the snapshot became zeroes or all ones, and
    pci_restore_pcie_state() wrote that back: ASPMC and CCC were lost in
    the first case, ASPMC was forced to L0s+L1 in the second.

2/3 Update saved LNKCTL for every function of the link

    pcie_config_aspm_link() programs LNKCTL on every function of the
    downstream component, but refreshed only function 0's snapshot.  A
    driver calling pci_restore_state() from slot_reset() put the other
    functions back to a stale ASPMC value, leaving the functions of one
    link disagreeing.

3/3 Disable ASPM left on by firmware after a HEADER quirk

    A HEADER quirk that clears the cached L0s/L1 support makes
    pcie_aspm_cap_init() return before reading LNKCTL.  Firmware may have
    enabled ASPM on that link, and because link->aspm_enabled stays zero,
    every later request finds the link "already disabled" and leaves the
    hardware alone.  Mark all states enabled and disabled before
    returning, as the blacklist path has always done, so the next
    pcie_config_aspm_path() clears LNKCTL.ASPMC.

The first two were found by inspection while porting the L0s/L1 caching
series; the third is a regression from 30579eebba6a, which is in v6.18.
None of them has been reproduced on hardware; the analysis is from the
code paths quoted in each commit message.

Yaxiong Tian (3):
  PCI/ASPM: Only update ASPM and CLKREQ bits in the saved LNKCTL
  PCI/ASPM: Update saved LNKCTL for every function of the link
  PCI/ASPM: Disable ASPM left on by firmware after a HEADER quirk

 drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

-- 
2.43.0

