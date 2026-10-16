Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BE30E858;
	Fri, 16 Oct 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131226; cv=none; b=D3TzD8NoXAyd/iaxuhjSRhZ/wXf2O5o0qPe8PBw6hBanjxwVKY071JJP8M8XnMlRHjhOptDAugNRvzSPeHNS6/OywLz+YCMjRsY/4qLXN2ZhDSFi/TVcQ85e2iLbkMIW61IYavqPFkFarvJuVvkmHStTIgGMxFIgkUGLCjCC82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131226; c=relaxed/simple;
	bh=Af8SMGNfnkwYPmWUsk3q9p7nVTZfGMT0E8rjQAaytQg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=eoPk95+RB9Wv93wshi38HHTxV3Pdp1s3Z2XN4P2VbQT79gIj7aNiBkXQlkGx0S7TmOcXW7dLzvCKs613qIgsXYUHFSY3RNecxZj8/BUrglBsquyWtOBY6ICPxv5Jcuwek8hCOukmKAGe5EW77zsN0ZfC3XhjCZenSrli0JVe8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10A91F000C4;
	Fri, 16 Oct 2026 06:13:43 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: qcom-ep: Clear runtime PM error after
 pm_runtime_resume_and_get() fails
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org
In-Reply-To: <20260925103254.EC98B1F000FF@smtp.kernel.org>
References: <20260925-pcie-ep-rpm-fix-v1-1-855d56cce43b@oss.qualcomm.com>
 <20260925103254.EC98B1F000FF@smtp.kernel.org>
Date: Fri, 16 Oct 2026 11:43:34 +0530
Message-Id: <179213121447.63727.13789617751814530058.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Af8SMGNfnkwYPmWUsk3q9p7nVTZfGMT0E8rjQAaytQg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq0cCROROAmyh7OsJ6DwjKX8Xl35KbKRDolebFs
 BODjQM7ZKKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatHAkQAKCRBVnxHm/pHO
 9Zu/B/9vZYRpA6raRTy5EgqmdGbV20fcbUeUCynpCnlSdSx2w0nUGkeptBNXTHKK6G/lIdCJPCd
 Lf+8KCqjETigzRwy6MBcLOjx0lRuJWc2KUmvyTIdvSYIJybNpIHfRFBUJMAe24aY7M7+dsZnW+n
 K7+Jqu0jpny/Xw396k/wL4Zu4NpFsLj8SHbTuDgRMsKynnH1s0pKxLtRxFuROpgJ8ZLEhISfxxE
 U0Cu1sYUst14BgavnjHH8Z1r++9NQJwU5hhz9uI7eLladTFT382AvsVkvuxg4U9G80y7kEWNDdM
 vC8xzv9Fub858zNRYWP2+gIrsbrhZwZcWLdtxqDCB6WABx1a
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-25 10:32 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] pm: ineffective pm_runtime_set_suspended() due to false runtime_error assumption
> --
> 
> commit 3d108ba33ceb10b064e31ea4a0bb76a46a7b974e
> Author: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> 
> PCI: qcom-ep: Clear runtime PM error after pm_runtime_resume_and_get() fails
> 
> This patch attempts to fix a runtime PM recovery issue in the Qualcomm PCIe
> endpoint driver. It adds a call to pm_runtime_set_suspended() on the error
> path of pm_runtime_resume_and_get() in qcom_pcie_perst_deassert() to reset
> the runtime PM state and allow future resume attempts.
> 
> > pm_runtime_resume_and_get() sets dev->power.runtime_error when a runtime
> > resume fails. As a result, subsequent runtime PM resume requests fail
> > immediately until the error state is cleared.
> 
> Is this description accurate?
> 
> Looking at the PM core in drivers/base/power/runtime.c, rpm_resume() does not
> set dev->power.runtime_error upon failure. Instead, it merely updates
> runtime_status to RPM_SUSPENDED. It appears only rpm_suspend() sets
> runtime_error when a suspend operation fails.
> 

This is accurate. pm_runtime_resume_and_get() failure is not setting
'runtime_error' flag. But if this flag is set, then further pm_runtime_resume*()
attempts will be blocked by the PM core.

So the issue this patch trying to fix is valid, but the fix is somewhere else.

- Mani

