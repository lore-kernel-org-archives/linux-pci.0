Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFE33D6D7
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774550; cv=none; b=k4gjTOhFkKkawcxFm4BuIuH0dE+hRhZ3HEHUSkLvY3MvNC/wGCwrFepi8mGdof27Js7vLNFSA9Nbj5Bw3scFvT9qBydlWpwMAmiFHFweMyI1ysnV4YNh4cPBGQO3PTdjJ/b9z4pG16mCMKMVVH0zs5OWudQTrGRoBgxWGia0Gd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774550; c=relaxed/simple;
	bh=EH6T821OGBEq2OI/XgKpnvqlQqJ/6osaeC3ahIlCVLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=njMxJpiNr5p0dQ++ndWAF3P++6cKR3no7P14T0L05nuULZd9TZmqM13HpJOYQCvuFiqTO0rjg4IB/VoYnTw4Ub50rtd526iv905bWBw8kK4JPb3RzNRS7odB9yVFQyEzVLACaQUsfBo1WELUH4M/VVM/ZlDrq1+QomS1z0JqLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36C51F000E9;
	Mon,  3 Aug 2026 16:29:06 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, Koichiro Den <den@valinux.co.jp>, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260730122045.1382749-4-cassel@kernel.org>
References: <20260730122045.1382749-4-cassel@kernel.org>
Subject: Re: [PATCH 0/2] misc: pci_endpoint_test: Doorbell fix and
 improvement
Message-Id: <178577454647.27194.3005886799360312801.b4-ty@b4>
Date: Mon, 03 Aug 2026 18:29:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 30 Jul 2026 14:20:46 +0200, Niklas Cassel wrote:
> There is one pci_endpoint_test fix and one improvement related to
> the doorbell test case.
> 
> Kind regards,
> Niklas
> 
> 
> [...]

Applied, thanks!

[1/2] misc: pci_endpoint_test: Fix doorbell success logic
      commit: 37ddcce6904c20c6a7debe4751f6a82f218c3bae
[2/2] misc: pci_endpoint_test: Improve logic to check status for doorbell test case
      commit: 0a6f72eda328c773324555491e1ad7f0b0153155

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


