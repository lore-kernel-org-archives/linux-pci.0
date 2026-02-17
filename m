Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DB27991A;
	Tue, 17 Feb 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323531; cv=none; b=Z9q0XgE0UvJBUEYmzNUcsyGE+DgF7MkBrpEtb+ifjvxo3hDrBLSLy5qGtt/O50rfXqmstXvGAZTeXUMqgXGEFU+Q1Guv3wSlNnHHl3RGvOLB8jIZItY2TnoLP0ZASwEpUfUPkTivt6ofDTi8teQozRFYpSqiq7ZTP+cohOQQJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323531; c=relaxed/simple;
	bh=mk61giFA4xV0eLiVM9N9Pk4Frb15EFC/PHziiymACBE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=st7dO8lkhuUlgbzvccUqP2e2fmm10K7hA3R5g5srZ4xTFGAGPpn2aqLexxfEUh7ZKYRW+ARhKCgVd+lSMR3+Joouf6pHvQwSPDbdAcIMeGKGHoSfKWaUcByY49WprWPhDDkmbhp65X81ALF3Zpu5SWefUtQsov1qnPgBeSqC0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS1mqRTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS1mqRTr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80A76C19423;
	Tue, 17 Feb 2026 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771323531;
	bh=mk61giFA4xV0eLiVM9N9Pk4Frb15EFC/PHziiymACBE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VS1mqRTrbfNFeZL+ljoQR8bewsQBCEZrVQiQ+nhmxyc7luw9VOX7ZY/QbD6M9w3ZE
	 E6dpWxFr8Ydix7nQKmtk9lTkDE1Sngg88EzZxgQ8bKqyj4LZF2mI9E9RcRpDmZwUXO
	 V++wgDUpXg6CWsC9+iAv82YqnX78dLJWYy2G8uoARVED3TpI8CbJpk87sWLZU+TiFV
	 keEBNeT93+hUbis1xSmAUOQjqx6M9g6Pp3QDKq+kXDQ5nTs1A/pEWYce+vONqP7IeC
	 llAY0Df8FfUbaM+Uzf/QtN7aZyZl0VZ5rZtKB//F5Hqv0rwN/BKittV/HXEwu6NVEa
	 BB2bAtHdUcZ5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAC5E68162;
	Tue, 17 Feb 2026 10:18:51 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/2] PCI/pwrctrl: A couple of fixes
Date: Tue, 17 Feb 2026 15:48:45 +0530
Message-Id: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVAlGkC/x3L0QpAQBBA0V/RPJsaq2z8ijzYNcuUlmaFkn+3e
 Tzd7gOJVThBVzygfEqSLWZUZQF+GePMKFM2GDINmcrifqk/dMUgNye0SOhaYleTc4Et5G9X/mP
 e+uF9P3EfxHtjAAAA
X-Change-ID: 20260217-pwrctrl-fixes-7-0-b90eb30bbfe7
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mk61giFA4xV0eLiVM9N9Pk4Frb15EFC/PHziiymACBE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBplECJmIxMp8QWihoHmtHt2sppe24sig6aGRzb0
 zqu28jutDOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaZRAiQAKCRBVnxHm/pHO
 9XEAB/4ygWviF5uNJoltOELiKg418BuWOKetvdb2DITohmc74t8Pd0vP8ZePWSbdMDyd+u9+SBA
 e9vSEaVWKWAxdwwuCykqjealjjb8Xa9k15nmVWYxuuKJ2kX9mWDSxpxRH4xq9AA1NUxDmAf+zgO
 NV3sXLWSczgSDRJdjbli/8iHAfOWWAfY3ljEBkPPBpA0JZAkGRf2kHUAmkljeTyVJrDsWiC3Cim
 Bk5rM6CZ3py8oBsYdPxDsoIYZAAkN6KAm2utZWwnEAAnxJIPiD00HV+ZAcF3B/GX5My1ki/p38v
 TymnfKFFDa3/u7EWh4Tcw7aaFVOVYyiwqz3DMRxnd9ArN+6l
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series fixes a couple of issues introduced in the recent pwrctrl rework
for v7.0. Both issues are due to some incorrect assumptions on deciding when to
create pwrctrl devices. First issue is due to assuming that all OF graph nodes
require pwrctrl and another one is due to assuming that all PCI child nodes are
PCI devices.

Both issues are fixed by changing the pwrctrl device creation logic in
pwrctrl/core.

Testing
=======

This series is tested on Lenovo Thinkpad T14s.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (2):
      PCI/pwrctrl: Ensure that the remote endpoint node parent has the supply requirement
      PCI/pwrctrl: Only create pwrctrl device if the device node is of type "pci"

 drivers/pci/pwrctrl/core.c | 51 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)
---
base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
change-id: 20260217-pwrctrl-fixes-7-0-b90eb30bbfe7

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


