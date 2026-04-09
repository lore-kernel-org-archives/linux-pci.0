Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE0250C06;
	Thu,  9 Apr 2026 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761517; cv=none; b=G2UftwtmtTqffJXHe9pcmEY2Yw4aNVv7gexGlFiN9RA0+d/2Am4hNrR/9mQGgksLqdJaKBPsTXfnsVJ2h3v5+2/81Ehp+Gt0Sl4lqg08vfpZ0o9pyImgHDyduppqIxOkABMzywtfjrog7rD2utl4ss4GSBmUcd9n2TlEIkZAbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761517; c=relaxed/simple;
	bh=5aNjZOyeKYoSPBrg6F+tZ55XEXLPMHj30+4MKI/30HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xz5BX+rhX6Q6BvvikD8Io7QkefDet6Obp2bOJMZhVNUEMLvN5aK7uG0uq7Vk6sORSc+Q6MqgnzofFiflRQstMSwTtkNR3+8tPftXQJ2m/1+/KLWmq4cSJuTl1DuozIAdR8Icj0pl4jAraAocOw/SAz5TldjXcAZubblIQNOx0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6mPrAhT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6mPrAhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B340EC4CEF7;
	Thu,  9 Apr 2026 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775761516;
	bh=5aNjZOyeKYoSPBrg6F+tZ55XEXLPMHj30+4MKI/30HQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P6mPrAhTDzJ3LoSeIIO/wJWeaLl/PA2qFqDGAvgGhfpOC91FBviGv06+TblUEt8B6
	 Jh1PEng/KFsT5uI68OEaQIEbU7Ygm5tBtVC47h2doopJw9bqrH8uRl5V0Yqn453BRV
	 d5Tl1XWek2KI4eKqjbV3ez0uBfhKZfJ9JGs5Oc7y97yMFMd4rvuyotdlVYmOn4P1ZV
	 0cHAGqObqHjC/sUHNOcNtEVF34ABCYMtgQvNI5/TvOkXnRSRnaPKOq8tfxlVbGbWsC
	 jJF9pJVcJQDXfEgAVTC16dfJ+5uur0aJenks5Pyu4Mxxq7IPrW0W1Dus5Xw7qcy5OP
	 bDm/w1lfRJpIA==
Date: Thu, 9 Apr 2026 14:05:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacopo Labardi <jacopolabardi@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [BUG] Lenovo 83JL / WD SN7100S: intermittent loss of secondary
 NVMe after s2idle resume, root port 00:02.1 retraining fails
Message-ID: <20260409190515.GA407093@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrGBMBDftu58R71jvEcZ94D8vJB2Y_dHG=BbNSsNMOS=3k0+g@mail.gmail.com>

On Thu, Apr 09, 2026 at 04:52:20PM +0200, Jacopo Labardi wrote:
> Hello,
> 
> I am reporting an intermittent suspend/resume failure on a Lenovo IdeaPad Pro 5
> 14AKP10 (machine type 83JL) where the secondary NVMe drive can become unusable
> after s2idle resume on Linux.
> ...

> I collected a local bundle containing:
> - full kernel log from the reproducer boot
> - systemd suspend log
> - lspci -nnvv for 0000:00:02.1 and 0000:bf:00.0
> - sysfs power-state snapshots
> - dmidecode output
> 
> The raw bundle contains machine serial/UUID, so I am not attaching it publicly
> as-is. I can provide redacted logs or specific files immediately if requested.

Providing the complete logs with private information redacted would be
a good first step.
