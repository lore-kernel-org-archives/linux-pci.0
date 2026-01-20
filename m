Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6F4418C1;
	Tue, 20 Jan 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933027; cv=none; b=pihwH5YtgF11XMCQhXsFu9086LswoWp/WrLHaFALOL40E/kpUbRJINNd2RVI12yZUfL/Hnawzu3Uq+UnqwzzOgs3CGLQQYLwt5BKcANP8skIIipVb4znqg6ucEsF5knVDthT3j2BCIK6wvOwgfiqdxpccmw9/RWVUNKribrzrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933027; c=relaxed/simple;
	bh=gxwaOHzp3uUOewUvUbS26LKL9lEmPjguIBWuVuODAfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b0g4w1+dtlY3QbMMgbDVPCiwnANvsN6pz58skrK8jRSkqemDK8++2EeCP/QBNzujHa5QtMVytwbcQR0D6tEE5rF6sG4sCAnjITxv5Af5d1KQRRhTR8RpvDF9Co7DQgIe+6GlAlvyxrNuqqF2DlwxUS9EHX0QXLFi9GWNrK0d1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq7D6bc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq7D6bc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A96C19421;
	Tue, 20 Jan 2026 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768933024;
	bh=gxwaOHzp3uUOewUvUbS26LKL9lEmPjguIBWuVuODAfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mq7D6bc0tjOypxE/Mzc2JviiWo/kcebpjtQ8r2fNEemQKvg5NUTFYBbsZnMAx+pAu
	 XtsIns0n6/v9+OYgxJ0WA3kyGR1BD3+JE3Z5X4omHT+aZRRbQw7gBxMEqCXUlqaP2s
	 WKPWUdrBKC9KCadu3agP5Q17JuIzFtU/LAvKtcEH+MtGHKRQKZ60gm0ZcS3fihfeKe
	 5h/XcETiuRtq7GCqDmnNJ4Jw7sioyF3wjfCYPYrDsE6Boc3YxTFTvgtPbh0SM3LqEn
	 44qo9E9pPfff7f/a4cRFQat8/6+ORYxfpCUVyxMSThIzLiqN1+J6cWtruDLm7acSsk
	 bJe/I29ye09Vw==
Date: Tue, 20 Jan 2026 12:17:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.de,
	bhelgaas@google.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org, kw@linux.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] ALSA: hda: core: intel-dsp-config:: Add support for
 NVL
Message-ID: <20260120181702.GA1160036@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120083148.12063-4-peter.ujfalusi@linux.intel.com>

On Tue, Jan 20, 2026 at 10:31:47AM +0200, Peter Ujfalusi wrote:
> Add entry for NVL variant of Novalake family.

s/intel-dsp-config::/intel-dsp-config:/ in subject

The internet (and other patches in this series) seems to think
"Novalake" is spelled "Nova Lake".
