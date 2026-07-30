Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E737DAD5
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414057; cv=none; b=sMkHlx/Np+XyhOqelZEiesR3qq4QYmgthn8WrljnWRkvp/iMHVilxCzJf45DMyxrhax3r8wc63ecpjuj56q7Q23fIVfStFiSbnSeEPRaHIO6gSjClJE/c5oYhnGA2wqy3v85q7DsI9OUnh9/VLqwQrYRc7GVCUCNBlV98HmSowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414057; c=relaxed/simple;
	bh=Jpewy8+W0+cooFgZN4CKqYuWSd39hgg7TzL7gU+EiU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTSKz1tNjy/i9MfPIcWHnVMO4EMYuNBt757kDUB91IqbxLvtMuZqRIZ+ntlxt21hI7OoQ+NUKYGRCqIgNPigkSgg0RwLcd4W/LqduN7bBdoFJotetUC9MOGbgmjJLTnkMFWLZzi+k09PxMdEv9PB9FUKg+trAyc5XdhgcZfi/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogAwTYZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogAwTYZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9231F000E9;
	Thu, 30 Jul 2026 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414056;
	bh=7Cn58cZo0MNuE6q7CB50iIVU8H0tmjiTj2IRn/VOeoY=;
	h=From:To:Cc:Subject:Date;
	b=ogAwTYZNqDb+GdAfrB5MNyKERgvBMhB9CyXbdYXU6SkmNiAee1c4g3RddVFDB1/6+
	 GNgaRUk64KMU2VZbpZtRtc3LX13lF4/5A5QNMABfO4A6lcgjhYPcPzKD8LWY6pk9cN
	 F31ED6x5EbGcxDsXiUEZPTft3CUh38jOZfO7yiitBtsQnYEtJZphtbT4KhB89X1uXJ
	 aIzQNIVnVCEQvAysFgnw69ectf8SRIkbZsMyPznS1AQUGTLVh/RJ6tpsK5we+QaNgm
	 TEzFvdbwTgzm/lIAgkFOteAtB8U/wOtTPPsmxv1V4+g6wgCDsF5BTBfcAXD9db7wga
	 Hl/e3UbA0wipQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/2] misc: pci_endpoint_test: Doorbell fix and improvement
Date: Thu, 30 Jul 2026 14:20:46 +0200
Message-ID: <20260730122045.1382749-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=419; i=cassel@kernel.org; h=from:subject; bh=Jpewy8+W0+cooFgZN4CKqYuWSd39hgg7TzL7gU+EiU8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKyHec+1+yxiLecY5PltCyR48a/3818SXfdbr1UvvrjK ePR/oCojlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkkRzD/zqtnvynQbLZG0yk J/0PObf0YmLkzJjNU6uK7/wKnM0xk5OR4b/J3eu5i6oVjq1eoWiYFvn6UlDsnt17BbgON9lqHO7 6xwgA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

There is one pci_endpoint_test fix and one improvement related to
the doorbell test case.

Kind regards,
Niklas


Niklas Cassel (2):
  misc: pci_endpoint_test: Fix doorbell success logic
  misc: pci_endpoint_test: Improve logic to check status for doorbell
    test case

 drivers/misc/pci_endpoint_test.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.55.0

