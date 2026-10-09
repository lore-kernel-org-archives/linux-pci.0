Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9A3B9D99;
	Fri,  9 Oct 2026 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530825; cv=none; b=V9WoaGxGt9BXkVdeYKZF/PiWLYgEDrl8R1ZUS6LZr4rvKLeKbG4oqkt3orJqY3JIiYKZq9RcrfTEonPEiPRYSA6DhfjXl3VE2Pb40H/CLk7zXEe8Mkk6oLspklXi2RpsOYwPcC9Jq+p/09U8ezI/YAbTvT/9ddM0zAqDGmVWkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530825; c=relaxed/simple;
	bh=n9po0z4TdMIQCmxEL5t2a5BSSnfysi/egXRQQdGn2u4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VBzZm61Vqfqzwkegwo5s+dP4FgmrwFlh/AVMSmCZwgZPHR+O8ekdLHd4MLWNobPrawCCzTsCNI73KlkbcZYR8eUHuuPFXEu7/o70qXerGbXwiH0H0+UIxb/yvMOYqkCKb365sM4vquiP1HgnAH529I+vl4mHyURe0P9ej4+K4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1791530726tfb7dafd1
X-QQ-Originating-IP: 1EqkQPE/uoYODaySpl2QOIumuwwVYc19p+KfVW+8wsk=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Oct 2026 15:25:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4604448789904762083
EX-QQ-RecipientCnt: 13
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH 0/2] PCI: of: Skip config reads for disabled bridges
Date: Fri, 09 Oct 2026 15:25:16 +0800
Message-Id: <20261009-pci-of-disabled-bridges-v1-0-08708f9e1802@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTNJaQwKVyEsaOcvjjFAOmpMC
 He36vJbvLeTISuM+mqnjJearktBU1cUr9Myg1WKyTvfNs51vEXlNbGoTeEO4ZBVZhhfTq5N59h
 5gadSbxlJ37/zMP5tz3BDfHx3dBwfwq5o7nsAAAA=
X-Change-ID: 20261009-pci-of-disabled-bridges-8406f7c92de2
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Daniele Briguglio <hello@superkali.me>, dragon@radxa.com, 
 Xilin Wu <sophon@radxa.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=sophon@radxa.com;
 h=from:subject:message-id; bh=n9po0z4TdMIQCmxEL5t2a5BSSnfysi/egXRQQdGn2u4=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknpj2YkKumKpS6y+PTzKQnO+8lyNTFXPkpmlWd9nZu7
 UFpkdcsHaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACayTYfhn8lD3vIFZ1edODi3
 cXPPVs4Hd6ZN3f2C+bqCz4RnqzhVP/IxMuxjf73lzMK+8ryTRU1Zpu9b/jeEVJWt2/ekWPb6K7W
 ODVwA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M2rJoAAR5VBfJBpig8Tf8UIfnN9PRwtSdGXAJESC/twrp/4JbZT5mY7e
	ItPOixyuImyTyAPqVSJhs/SQVU0oDErcF/gO5gdr9DVLGlg7A6TEqH34tGUaT4L1xUL6/Md
	tKI5ansqmvsTmTOc5Pq5xHgTHDurS8VpQWzHDMs2erQxtNpAFwWP8ynpYyrtpwfI31tLnkp
	Qo2PG26r1GwTQiFh2APzQmd6Gfxt9eahS+dFeTPadz9d0ImC3Jx/RLp4yuzLyi2w5KKoPrA
	FdLqeiktnfV7gLN9OlbJIikbbzIRSYAllZEBq+j1R6y2cKiyq/840saYOPpONEymC0gyImO
	g3TqVnl8GWEiJ+wp+JvQquMalUEObezKV68/oiPswDklechzgG4JOrrYY4iLREEbOSmJE/T
	vSEky1FwVh8mR5lC7nTaqKGBozwRdI8R2lGAXCQjXFiKFu8+6Sno4mUWO2jI9Z2nWRGyBZw
	gcqy0h03T+zJXd+IM01FfihrTfAK2kBOSlFpn7eyzkQOkpA1uht3kjccIVAze4zva8STK2r
	mCS9hiGvJR+AOeOfTA2+HhkZdkqwY0Qzz0osklm7aQabuSx8HpOevREzTCaJOKF2mhq3yj0
	jOeM5h65aOclG1D3KBlsCcwEsT0YSjeV38Nv/k6oCDCq3nYh5NJXePqtycI7CpyRHSxn2vc
	7MJMds/TrrFWu+pEGAmmaiH2dfqupq8HKGe5HgOY/OIfWA7+qFF8ED81ye3YkZSzYf/m+NY
	rxTsxH+NtSjUbH45Y5sxFZxybHrZxBIvLSiIi5zHd2aKNK1ZI71XSa2JXuPVjL8IyAC0An3
	fRYQ5CRvE9+1SdfiS7wu/J2YH2uNPzWayBQXZwVElXF3ugbbh1tf25FMHvSnb+tFbRdih2g
	XW/8HmbJEXRy4b/ecrUu+aqSMxnssQq8G2mDrwo+w6Yl7e/j3VZVaJiCfobyENtx1EpwgV0
	qILdremnp2pAW/NFzYY3YBh1O6g2muWP7xD0lMLLTFc2VL+I1qnDKr3cSxGLQxLOEWrTIrq
	zd6bm2UVE5+K7pcKz5tZkmXA2DP+Zr7pZhbDTHsHKPj7ArCSiG0sLdZpCXhyP0VUkcPCuQU
	JI6Ke3xxUKbh4h9m96mqsHtFJe0s0Q2jobW/hTNktcLiVo3PgEZ6YDnBUUv6WNfLA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Hi,

This series extracts the PCI change from the Radxa Dragon Q8B board
support series for review and application through the PCI tree, as
requested by Manivannan Sadhasivam.

The TC9563 PCI power-control driver powers off downstream ports marked
disabled in the device tree. Probing these port functions on the Dragon
Q8B causes a Completion Timeout, which the Root Complex reports as an AXI
bus error, triggering an Arm SError and preventing boot. The Root Port
to switch upstream link remains up, so a config-access blocker triggered
by Root Port link-down does not address this case.

Patch 1 corrects the stale return value documentation for
pci_set_of_node(). Patch 2 skips Vendor ID reads for unavailable
DT-described PCI bridges before any config access. Disabled endpoints
remain discoverable so that PCI fixups can run, with driver binding
suppressed as before.

Compared with the PCI patch in the original board support series:
- Split the unrelated kernel-doc correction into a separate patch.
- Explain the Completion Timeout and SError path in the commit message.
- Retain the generic PCI implementation, since the issue is not specific
  to Qualcomm hosts.

The functional change is required by the Dragon Q8B device tree, but this
series has no dependency on the board or display patches.

Previous posting:
https://lore.kernel.org/all/20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com/
Review discussion:
https://lore.kernel.org/all/fsrr5xg4plfknfcvv5co4ciklz5pywa5bbfxbthwsnjevysr5v@myghuxblnend/
https://lore.kernel.org/all/r22to3joold7ugzwolni4qahyumcekbyugrl2bms3xmiysqtgo@hu5s3dnyqwsj/

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Xilin Wu (2):
      PCI: of: Correct pci_set_of_node() return value documentation
      PCI: of: Avoid config reads for disabled bridge nodes

 drivers/pci/of.c    | 27 +++++++++++++++++++++++++--
 drivers/pci/pci.h   |  5 +++++
 drivers/pci/probe.c |  5 +++++
 3 files changed, 35 insertions(+), 2 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261009-pci-of-disabled-bridges-8406f7c92de2

Best regards,
--  
Xilin Wu <sophon@radxa.com>

