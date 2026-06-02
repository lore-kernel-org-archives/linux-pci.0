Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4663B6C0C
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438530; cv=none; b=HzfO2/zOsY/i2KmF85zxaZ4QjtsqirSGa2bNraVP2vDev8TK/6z8MS7kuNc7IE8IITUt6d4Qa+CyZ8p/TPA5angAloeApxynNScWuutQxRZKzWP+dKPgIvFVfHVjg2b+spmNd+X5+AxDvjLbjBMA4QyIVKIEZtSSNut14cwMD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438530; c=relaxed/simple;
	bh=PkFkKBkasyNkfpdY3psVfIwGsVxbjYhDPSzlbu1Zp/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxRS2vEFdN+kNyHjlFa2Do1t1yW+zo2gkP6/TMm1StOyFON9FySy2xKA+8XY7AQdpBZKwnlZwhmnVSbwiEJYsjZwMoPEUXsTNlqpltjCWCVOvsTa3cOklL/lQwpMQE1Q7mQqyp7Yuzw3svm2rxALSSA1y+KQ/25sHs41OfUedGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTYOmuHG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTYOmuHG"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d8b644473so3108502a91.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780438528; x=1781043328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyg13nmb1cl4XVRXyc9+1Xf9pv1Lvsh32cV5wFSbV18=;
        b=jTYOmuHGSIBX9DfJAMz0WxP0meWF9ha79aFb3GomCFAjsUWxMze7GsZJolFPUDZbKn
         4fpn/BoLCWezVoIlVQcQgfYy0d2FBpLjbKyy1h6JPp929X2PYDqt9n51tTzLkFTm8aMM
         Cy88PMmDINZSXu2zw6wpsywHpPkzMCtHm/P7kGXGa/1hS8Xu7kVT60q7+F7/1Xozpzpy
         8wxerHJEGbvlWnqjpQX2myKgbtvPOYi8qC+/PYmGdeMQ7IoGJ7y856bsueeOnRXZAdaO
         Cv2r88j8UxVkfTr1eFkoeUI1exZB795/w/Y5iEy4T04TycfgCcgs+UjLoyaayewa/zYz
         RJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438528; x=1781043328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wyg13nmb1cl4XVRXyc9+1Xf9pv1Lvsh32cV5wFSbV18=;
        b=HX1budbNcID1tNv8NLoCbExrCOhnOrDaomm8HtqXw4gMyLy/tsgK+jzu2VLrS46gN3
         /HBqQCqganeuCDlciLGTikR9chQfpDNHMEJyLI+w3ftjkp/h1t25NAonKNtPCjl+BEni
         nTK4RpOk4Vn7nZ3pn4sTZiXtXuy4PBqUaJTl4En0YFokllofS8vModl3bvhn6DTAe5f8
         Wzs5Q7H1D7gx0ypbOAfudnfVi3fjiavYSNQQK0T/FONVyoN2DtFFJYyTfgip0JoDgxGd
         75es4Levb9WipLjmO5zp1AhG1VQcw3RMkOY22XZ5vOSXTtDcma/8d2k0rK8qe7h6aJrm
         woxA==
X-Forwarded-Encrypted: i=1; AFNElJ9rv8vId1G0J8w5Nra559CaDXyUev4wr0Got1eC8Atf3o6x0Po7TfE6DXx2Ue66mz2yQB0yzXj7fbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/EEd7VmRNW5Yt/3vVG4WTaeYhWCfnmu8XOIhMFbMF/D32vEe
	MFFS1ng2PAZ7Jj2mMhCFFz8hw+vgGUqTG4CpXg3+YB2YxNT2rU6pUqKi
X-Gm-Gg: Acq92OHLP9VcLuwo5MhPaAcxqyRN3GghuVpt7STRm59fOPk/7E8P8eUCmEyyrCXAhL7
	ouonshW4bbRmVT+UmKk5jo7eRy0tztT8e7nAyaIxm7Z4ymjEfOte6hUlE7aGtaQnmeQmTtHDAxC
	L/BnZTqL8nWAg2Vk91ebAVFe37M9TKSr34Fc6nMsYg8FdpXLVktKEr+nZlAO0oa+3knspGq9nDg
	NReXDT11Buu64sP/dBzEZTsh1yFAR4306sFK/yyH0A3J799dKrLGR0GYAfc+kMUYMCB4XSWmLol
	anCLWBWhkVoD58O329oNJrB+Vv1TxDGGC7+1QR5wI20pFLQrjvN0O/peoWSxrH+beaTApXT1sPv
	TAZE+lnfRhXiEJx4tyvf4/efUvG5cWilB+ZbIaUDijbO2NbhSwkBybbSq/Zhh7DIRt5vCnZD2uY
	hPJIAL+IUsHfcvESN907jOqn9O49Wmht6Pe4oGcTp3UprA
X-Received: by 2002:a17:90b:1d87:b0:368:a297:bd38 with SMTP id 98e67ed59e1d1-36e2f3c11dcmr712758a91.7.1780438528332;
        Tue, 02 Jun 2026 15:15:28 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e174db6afsm287366a91.2.2026.06.02.15.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:15:27 -0700 (PDT)
Date: Wed, 3 Jun 2026 06:15:08 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Zixian Zeng <sycamoremoon376@gmail.com>, 
	Han Gao <gaohan@iscas.ac.cn>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>
Subject: Re: (subset) [PATCH 0/2] riscv: sophgo: sg2042: Enable PCIe DMA
 coherence
Message-ID: <ah9VwHZbIuDSqmbe@inochi.infowork>
References: <20260331171248.973014-1-gaohan@iscas.ac.cn>
 <178028263198.557087.6386925175219722340.b4-ty@b4>
 <ah6gcvKQlHlrW1qn@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6gcvKQlHlrW1qn@inochi.infowork>

On Tue, Jun 02, 2026 at 05:21:32PM +0800, Inochi Amaoto wrote:
> On Mon, Jun 01, 2026 at 10:57:24AM +0800, Inochi Amaoto wrote:
> > On Wed, 01 Apr 2026 01:12:46 +0800, Han Gao wrote:
> > > The SG2042 hardware design supports cache-coherent PCIe.
> > > 
> > > With recent firmware updates [1], it allows to use DMA coherent.
> > > 
> > > [1] https://github.com/sophgo/edk2-non-osi/commit/017a5aea26a066fd2bf501b7893937183165af36
> > > 
> > > Han Gao (2):
> > >   dt-bindings: pci: sophgo: Add dma-coherent property for SG2042
> > >   riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
> > > 
> > > [...]
> > 
> > Applied to for-next, thanks!
> > 
> > [2/2] riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
> >       https://github.com/sophgo/linux/commit/e728a57834d06b9bbf9bbed69e3ea16416d257d5
> > 
> > Thanks,
> > Inochi
> > 
> 
> Revoke this apply due to https://lore.kernel.org/sophgo/ahu57vcS0oOFmCI9@mertle/
> 

Reapply this as this error is resolved.

Regards,
Inochi
