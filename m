Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671E3815E8;
	Fri, 16 Oct 2026 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128614; cv=none; b=UTD1aR+0LVeLD91qXJifF7jO56QaO6vYZmBKwBRK0royhsoENgLBFbuS5NmyJWMKm5tKTs5xPu8KCBigv7QOYUcq1W8azmVwRdwqXGyrtfBPvaRocqGdU1qUJVHLzZgfUGnfvCU39SvDD1UkJJt2eMAfupy/Gb6ogoQA3WS7YBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128614; c=relaxed/simple;
	bh=nJTyA7MIowsJxc5oc3zik8umZd61bBSFfPKWCJQL20M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRQxP7pnU7UmRi31RX6eKvclzfVUO3u9IlRtVd1AmmFm4NhKLblsICHxHu/MLqByGcR/lbqorpk1F41Y1l9DEXSW2EyOntTfnSe9cD6pDnRRv/3i98IlpYbqziZy+MPcuLyOd0y7TGNcYbUu0gjXYeJCnrza4wBDRIOPMSc54B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxRZ1Xe4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxRZ1Xe4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1011F000C5;
	Fri, 16 Oct 2026 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792128613;
	bh=HCwCK58rCE1cHGky1s7sNZbK/79BXUWwQJa50oSdc2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UxRZ1Xe4qYQo0JB/XckvueJzpMDSlzmPli7KYyu0KPkBSskjs8uyoG4MSKJ6/oYEa
	 i2wlhSkUUg/k+qomXzL8Sg3m8g5JcBbfyEFg+5QcHFU+EexDq9dvkge+OQIDOdLtVf
	 vB0iZL74TxVRBG2ycmWbd0uwl2fnYtNW0+0VzYCd0SOEPRKQ1VrgiUtfqvpc0Jqvz4
	 sOK5OrRKQ+cXVqQKHEtSZOhxz15NqsjpZgnGa7IzrJk4vcz93fVXvsAr7bL4a38PdW
	 o52mUB9edWgatJDPRKA39mc4sS4nq5pfL92dEUbAQJeg3vkcPYJ95wgVSFso+7JlTq
	 l9sbhxyDHFfZA==
Date: Fri, 16 Oct 2026 11:00:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Add Foxconn WCN7850
 subsystem PCI ID
Message-ID: <atG2VF4F8RG_fmId@debian>
References: <20261016051745.577777-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016051745.577777-1-val@packett.cool>

On Fri, Oct 16, 2026 at 02:13:35AM -0300, Val Packett wrote:
> Add a new device match for the PCI subdev id found on the Dell
> Latitude 7455 laptop.
> 
> Fixes: a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID")
> Signed-off-by: Val Packett <val@packett.cool>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
