Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3D1C01;
	Wed, 22 Jul 2026 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699697; cv=none; b=SCYJaILDE6rUgyIU5YAjkXdcgwKgxpNViT8U+dhLdX+YrX0nONAbCfaXFxnUQoJf7bLgOsh6VV7P1qVh1idOAUrb3qzOqQCJr54LC6MtnAF9gOZwgBOt+StJ77xLYciTlASXqKt10c2xXa6htQ21xyVK8mVb/jPcikzjfEUDk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699697; c=relaxed/simple;
	bh=Lhh0pqvxZoxlABvQd8zbDNaeva+7Z1BTwO8UUZ1oIrw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLbqK/d0RDZu6rXkWBS/sPYwprPbUFvKHcMfp9ixckiYKy7B3DbqYVIe93Gz4Uq//T9ot7JN/1Dwj97n8jqsBisgS23TI453Sk1IvN1CxZnGndpf//zqbMKHLSND/uOD/csby4r+wLZUFeluKHFDYwj17r0rWdnr7eJb0o0w63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E75WO/54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E75WO/54"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D637AC2BCF6;
	Wed, 22 Jul 2026 05:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784699696;
	bh=Lhh0pqvxZoxlABvQd8zbDNaeva+7Z1BTwO8UUZ1oIrw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=E75WO/54yYlLT2nJNwaL5VfXC574Pnmm72PPGcqKmgSxmMQZ8e9zXd2NMal4goC/z
	 ScVl2e/C5Zlkp1WQ24FvplVZGu907Ck80ILIGGhP8kK3meB3yKsVje3E7L5Tv0b+1g
	 ZLNQZcGscxq3eP0UpxU+Rd857cJLMvalXvS2thKSYCAkgbCe78mlA3rlXNB0oiJfms
	 F4o8w0kreqO1SF4LUiTzOqqcjyTrXbHQWl0N66M5Lua7qO/Hne2a9gwuSNHChBOgjK
	 knoGM1A8IJbHFndrJy8bYzLGeP3OfkZKQdnaH7dCi/kOXlGlimfrHm4ieFbWBp/wwY
	 tdxMZEqmby62g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6918C4451C;
	Wed, 22 Jul 2026 05:54:56 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v3 0/3] bus: mhi: ep: Implement flush_async() callback to
 flush async read/write
Date: Wed, 22 Jul 2026 07:54:43 +0200
Message-Id: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACRbYGoC/23O0Q6CIBQG4FdpXIcDCtCueo/WhegxaCoGymrOd
 w9srdW6Odu//ec7Z0YenAGPDpsZOQjGG9vHsNtuUKXL/gLY1DEjRpgggkncaYNhwE07eY0VJ5w
 wSfOyqFFcGRw05r5yp/Mr+0ldoRqTkRra+NG6x3ov0NR708U3HSgmWNI9kJoLyGV1tN5nt6lsK
 9t1WRwoXQjsY8T2j8GioUR8ThFKIed/jGVZnqiiB70FAQAA
X-Change-ID: 20260627-mhi-ep-flush-b50502718a9d
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Lhh0pqvxZoxlABvQd8zbDNaeva+7Z1BTwO8UUZ1oIrw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqYFspGU0BzEtM5HB3eyjwS5mMq6xKzReuGhSoo
 Yw9Y/POS2SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCamBbKQAKCRBVnxHm/pHO
 9TtqCACDRwgBzyex4JmTeNdB2W2tKUwwjAvK0laFYJMUjiX80/1+PT+QFZcqrZ4kTUPTXB0OuAB
 4dfOJmv/qFbkAQdWzEC24QTLXXBPKPuxcycVka5FpnhF9df4NXuU/e1tt95yR90ACGuN1ct/NlV
 2qE7vbeJWEoni2fv5w230AUqnoFbbCLUjePCmRITz2n/FtwC4CUe6SXpzmlM5M+GJjzF+qzy0iF
 gqV3Dgd+KBK8/QIdmuFAHzxLpTrXqive2tW9b6SrV24cqSHhHExtXp+PiHHqUOmFEKHqZCTPD0d
 tYL0Oy0/ygdIrigH0yWMYfZIhlCgu92lsDAHu7wvWqwyEqle
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series introduces a new mhi_cntrl->flush_async() callback to flush the
async read/write operations performed by the MHI controller using offload
mechanisms such as DMA.

The MHI EPF driver implements this callback by flushing the DMA wq. With this
series, the MHI EP stack can guarnatee that the channel specific xfer_cb() won't
be run after calling mhi_ep_remove() and mhi_ep_abort_transfer().

Merge Strategy
==============

Both MHI and PCI EP changes should go together. So I'm planning to take both
MHI and PCI EP patches through MHI tree.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v3:
- Dropped the dmaengine patch as a variant of it already got merged into
  dmaengine tree
- Move flush_async() callback before triggering ENOTCONN
- Link to v2: https://patch.msgid.link/20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com

Changes in v2:
- Switched to read_poll_timeout() in dw_edma_device_synchronize()
- Switched to dmaengine_synchronize() in pci_epf_mhi_edma_flush_async()
- Link to v1: https://patch.msgid.link/20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com

---
Manivannan Sadhasivam (3):
      bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read/write
      bus: mhi: ep: Flush async transfers before notifying disconnect in mhi_ep_abort_transfer()
      PCI: epf-mhi: Implement mhi_cntrl->flush_async() to flush DMA read/write

 drivers/bus/mhi/ep/main.c                    | 41 +++++++++++++++++++++++-----
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 10 +++++++
 include/linux/mhi_ep.h                       |  2 ++
 3 files changed, 46 insertions(+), 7 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260627-mhi-ep-flush-b50502718a9d

Best regards,
--  
மணிவண்ணன் சதாசிவம்


