Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780271;
	b=HzERs9/0PbvJbIs3ERFAISHHsDzzijOMS3gR1rMTTpR3eF9oV5BljkKia1gwbQXp8Szx
	 aGr+Zq0n0O59s/K5+FaleHWHbDQGKMSfNkOAFAbFivz+jJ3W/slkRIkDh3UhjKY1h4JqT
	 iHll+5oTAA5FQGI8IaL5ZCxCEBw7jNZZqJlg2kBf+0m0EzKaPOSboRebU7L+L+W3pcT1e
	 7RT7Njw2uG/Osm+xENsidqxTvFOAceKeWwxiT4xI83jrsH96uZ7kfWz3uxbdQlxmPRP9/
	 szTw/geKMKWYV4lr+abe3XERhgaaOgw5C+ln3WM5BMNZZT1jl1nHOn03dMjLOsIzwag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780271;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Cxz5HqWwc0Tf+woQsIa7iHRYSs7MniS7hkEWff8PtSg=;
	b=l4pQcv0KkTomo/g36fUN0CQN55QIPoZ1qh57ciJ2oAmTWHDhQzJpOFvyu5mKEBrvc+6N
	 FnnQg31F9RRjFMhj0xF3JnKEcqPfPzf0ThsLO6CQWWgw02JmB/GxZKgPxUqCfO4spFJIW
	 raD1LI/5sMns60J9U2pBcx6FSmmdANghAKpbZKQng+nfVAFDgR9KbST/VyVuBS3YehDEs
	 z22l9q1WDOljzckt2fNAIZhEnv9KYz+hDy1TxVttK+8m5eowzbFtzkoG0AIdAF0eNTFFt
	 gPUDNRY49BDqkbvXDLgrheP82bq8z1Q2kz15TgxA/lY7ZopTybNM2o7GMCvJ/BJ9YiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B040606A321;
	Fri, 27 Nov 2026 11:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B040606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1795780180t43244851
X-QQ-Originating-IP: nDKpBYq75ro2Gw+Tphk0DHhGS/9QtPiVEmZvro0mv7U=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 19:49:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14761476019748613940
EX-QQ-RecipientCnt: 13
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH RESEND 0/2] PCI: of: Skip config reads for disabled bridges
Date: Fri, 27 Nov 2026 19:49:31 +0800
Message-Id: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Daniele Briguglio <hello@superkali.me>, dragon@radxa.com, 
 Xilin Wu <sophon@radxa.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=sophon@radxa.com;
 h=from:subject:message-id; bh=Ihy8RgXbArIZ+Di5WHCfFkez4ZaM9ywlSfd7Xggdjbo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDNmceUHvJbfcYBF/FdGWxn6hVn661YxXMovk1k4pijB9f
 vvBVouLHaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACay9gbDT8Y7yslvZu5/+/74
 pXe2F6U4NnwSzG36FFObIPR481blW9sY/spcqzydL6g384P46d0zd/5L3NOlHcmw70mpVklzTtn
 EjwwA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MgxwSif07E1rr63McogQ0HA/bFrau7o+DHpmjVG/qbv51zl1KK1BeRfI
	6gJqsVKaJeYxvEUytox1SS1r1iMpBU7+bi7JWL8yJxaiynU9+HDg4sI69I+arp/59VUja51
	m1uD92OEmsmk5Ft5iXS+HyDLKUAMFflqqJU7YtuRvMQazg6FvAiVVlPJtzlHC7G+o75f1hy
	Rskj5sV40AFITf2oJangBQJGBl3InVyhM03uaUGAkRYM53mZSDTgC47cxY+RpIYfFovQ9/K
	JN4EDkk4QFE1fzHygCpCVyQUad/4lwN57hFGgGKpbXgcbPGAsJnNsYnxuUvql8RWQAkDjeF
	oE30V5sYngvIyGrFTEVMHxBa2T2VAHWkSSRjKgiMPnrX1R7KzBi3yJybHvx6MH1xqrwR6AM
	kh52mPQ47+HxN6w2YfwIK155pL7ff+RXCiOnqJ/MESzPka12nsbekP81dL8g4cKXu37wu1p
	6yRWFCKvY+Ap5ljbaAgZ7NOQPSfwKXvohxvULrNWomiJGbrk6pmJGGuUXrw90fP/Tb9sgnz
	ftMstEdmcbuM1naUGTTZHyhwRxw93Wg6ACNxpOxy6lcho5s9ttUOqzP58rqIyarumO+BxlE
	0PqTBujxgiz4yWF+aHQG+aTi0n/57L7slBm3fBK6Gs/v/tcg+3xVf/QCF6YmpjFGag4eJMa
	9zRApsWARZU020/3N6vI66QjuSnK+eiV71N/Bsru/GjovaNOUD4fprDl31A0hTsKAOmq0rq
	4H9KWL2TYjd0vm10FYclaEPx/XbQyWetj8PPnuccNdEgqys0DLOSlDr1eq8BD7ALDek6rvt
	Xc+/kwUpltqNrBdBSLyFMDal4CIcmosxGUDL/Vuf5tw4a9juhyTd3sf0Ifmz1ldfpXOPbUQ
	9zRIqqNzEN58ZcKeVbUgp65O1CCKIr+yrcyYUvFs7e5As6ejzjPGit1b36mYhHIXwLTFuNS
	8oFgvHrgcR1454xE7dBCPyTjG0AOkrXWwAhZBtYa3QLtq3pfXMv+VVM2KqDBxnDpNSdavM5
	T0megYnbnHx4O4uOAoeFz17MhutLwJ6+SCudLri7pxf67DcNmaSSHAQ6FSwFY7D19KyXLv7
	EcZd2VgtXVgy4Ln9OgKIDk=
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
-- 
Xilin Wu <sophon@radxa.com>

