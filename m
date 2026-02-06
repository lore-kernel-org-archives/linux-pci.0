Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FB2EAB6F;
	Fri,  6 Feb 2026 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416444; cv=none; b=g0WGcHYMlzT2lMtrh+B7lQq9lUDrifx0LNgtakRZ9gyoD8oEfao2SUSwSUwdYhBJvOhqOqPimIac6gT3+0v6d17xduPJpi5QboG+VgRcQyrPtmhkW1IaOtfcNYUx/H5QhpRSqFtJVy9A5+ZYTChMeaXUul2KrdfSWN56PcwcSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416444; c=relaxed/simple;
	bh=D4Ok5G++q0iR50/YiceCtR+1ZBWN8UcnMbIyW1O+OxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MeQsZQS5Q5anH0G2UPB86COGMEFylgzALOo2mI+UKvF8mnVIthYBtb8Yml1+dAWd1HScArtVljw/R4MXTOA7b/CR7vT+k/I3MyDQkX58U3TCD+hEiUpSGc55c1JVDosVzmvX2KZKzigbWWXk0fPdkAzBYwvw1RGnrqEmkTCZkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zclw/4cB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zclw/4cB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6935CC116C6;
	Fri,  6 Feb 2026 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416443;
	bh=D4Ok5G++q0iR50/YiceCtR+1ZBWN8UcnMbIyW1O+OxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zclw/4cB1+mzqd738ejy9QCxt3plgU7D6sHBMMTyyH/k+eX0qioSo4TJSfWTloj5S
	 nBK5bRNVy2tOzzopKS1MNzZONdB6Aq7+aYvrZJFlUdaAgiONevDOC8cSJi7K2+jPBk
	 ZCkKnmlMwiXcjeNZOM5BqMW1F7ToZUkV/yKIxG68675RgrNxJcc2mBsVAjr/XRg05M
	 WS5rXq/YBi04cViI2y7IsRKIGeu+vodT3/GW7oNVTvVEceFkUoBTpCc6UGx4XLgaNR
	 emqN+WS3y7TWuK0qszvZdoa9RMKCQLHU2WI98wG3UuYiSc3i3eX7EOd/FrAlzoH9sO
	 Lrn/E8d1HzCKg==
Date: Fri, 6 Feb 2026 16:20:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: zhangsenchuan@eswincomputing.com, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v10 0/2] Add driver support for Eswin EIC7700 SoC PCIe
 controller
Message-ID: <20260206222042.GA98065@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4vqlkw2cr3caqj7whlld7r2d5nenrxsufuc72zwwy5a6a5wmza@3haxytsqqigj>

On Mon, Feb 02, 2026 at 04:29:51PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jan 29, 2026 at 05:26:28PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > 
> > Changes in v10:
> > - Updates: eswin,eic7700-pcie.yaml
> >   - None
> > 
> 
> This version looks good to me, but it'd be good if Bjorn could give
> an Ack since there were previous reviews from him. Also, this week
> is -rc8, so it is too late for 7.0. I hope we can merge this series
> early, once v7.0-rc1 is released.

Will do, ping me after v7.0-rc1 to remind me.
