Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F727466A
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615951; cv=none; b=KfNGwsJqvXrH+dkBi13W5W1d+upC0j4rJ2nS0rvuakTOOymSoS5W6zpsDNCynECCLrdBwIX6AmE3oGnfjf51Hm/YINXU9AfZmlJAxhqN/SqPvm5Q0s9Uq7QKjB1HQjQP7P14PojOVvktPD6CWADu3ZmEVKcpGg437JoZQyXe6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615951; c=relaxed/simple;
	bh=WnPzOTBnOLBjWHSRy274vlZE7IROYEPKRRksgkVb/iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkboGw08aqL2DbOidmOVIPCQ4VZwkY+K02AWq+6+ypY5Epc0ngg7erTY/HGuuTySvJWHIbQquAh9o1xgBVivVteYDrR2yw2ZS0mSuL00XpH7DbUheF9T2x6b3h+eleaTXBy9m5iRCcFwRlxe128ulOeL9dQoTFTLdMBGW+G1gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VB3TXCXe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VB3TXCXe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d8facae850so3305ad.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790615949; x=1791220749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qGfj2Y/eKe1ZG7o5pFOTvuJbhKG8WlfCFzo9fqTzU3o=;
        b=VB3TXCXe+HN4r+UQAWPMjyHh4A31RCm1xTAKQsC0FoCk6lCiZ2+E9GXfnxE/s0yWN4
         JzawP+KLcRIX+3fnvJpegNySVke/0qQVAwvTXRZirdm4YOzMVphXaCiH+Ax0a2qu8yjR
         8f6WMexWjWjS+DB/9DRrZmF5+BAROEoQB8fBxpPfhTs4YRFVeXCv1WdQOGg3eMwiD0oV
         UfzPgfNMChm4mwyBT9jDjfvYVmbJXJLKB9ipARpQRj0NVTnCOE9r0XLBa9uonxFFGniR
         6JcT9ToseIDd1BBb8kQ8dD0QV3CH7dOjg837ntYDReMZSsvDPQKyh5zszFdu3PYxXyso
         QgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615949; x=1791220749;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGfj2Y/eKe1ZG7o5pFOTvuJbhKG8WlfCFzo9fqTzU3o=;
        b=U9FoAIub+vf2TcnkP6dY3irH75V8ZqMCPGQMXafWXh3wbdSHyb+d8YljEUEWEMaTJj
         xEYy3t+m2BbcHKm4pvaRam8xvmFYzgLyuipjSf4mWAAIWJEEcy5rE8hMBGR6/hY8ssIv
         Wru7N+MMJtuO65q95oPZ/aQe7pDbyw4sCNRycZFrw1DeSRG4Xmo9AwcPX5Bl5p2tNfk8
         /aj5YonG5HvhfJZzzHbWt4EJAZCW8tTScWNHrI/6ReAYIA2wSminIhUYQTU7OUAn8zUW
         Ik2NBVI8jsJ4EG1WGdK+OWV1QGq+ONuL3oyT50HKMSGjVlDULCaV8MnvFPTUMgB7nUkS
         IPqA==
X-Forwarded-Encrypted: i=1; AKwUvBx+FqGCkoi4ahhgE9H4bVICB2pTSZkMGLf8HEYW9yZztc6/WxuXVGeZcLfzpxExqnRHHQdrYcqdej4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpMbIPl8upAyPnpSEnzEXCq2LGFMp3gVk5NzZcvnLg45IplsJu
	4r7qMKwxSBz7OAFocZKdP1qUa9FI2ryTCibPOaFrDYzdO2q7qdRsx+xrzaNqtD1RVg==
X-Gm-Gg: AYBFou0LEUVHIZ/KnMKWHy/KpvQKK9QjFmTqDKLmYJwcjaAEspQ5mjFSIy3qOUD1Zhu
	/7rmD8crT8+G8DMGXlw4KkQPdFBhfJTY5Py61lFYmbsOYGPq12jsIseboFY98G7SwSVsDzEJw3b
	QruDAey98mUN7QV/LxFAo9s0AnwLc7gEciOEiced1IRtciVyhFcsGuE6MujN+Y5vodPEMW7H8Dq
	DFgCxzJTeqgqqWQk1VcqdllPHtIuJ8R2NjgqaaeVhVP0ParBB73ybh3Sofze6kSD7X7U21VV5WJ
	0/HN+H88BYZwW2nV7spNPkx5XB8rwUVqfKgQRWjWK1Ivkm/Y62DuxJyBhHXQtI8RQ9qRiSyoeS3
	YjknL+mPoi2LMiUmYkMQbpsunzSsdPmtuBFd2CVIj0KzsBu/ItlL98ByNfAq6E0g6TbLeDvoGva
	1A8e5CUGSrLSjLoShTteFvy/23VpRNXYkGJFMpn+NINwycw+7UmWmsBOeYm6sKr+5EMo3cHVu/i
	ytTScnfD0zBjA1u3mz7+n7+7qbHHEnf7w8O
X-Received: by 2002:a17:902:f70b:b0:2df:8e89:3bff with SMTP id d9443c01a7336-2dfa9795c44mr8307715ad.17.1790615948122;
        Mon, 28 Sep 2026 10:19:08 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7a4b03082sm2784007a12.11.2026.09.28.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:19:07 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:18:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
Message-ID: <arqhghssNc4fIu_9@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-9-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-9-dmatlack@google.com>

On Fri, Sep 18, 2026 at 08:06:34PM +0000, David Matlack wrote:
> Save the ACS Control register in pci_save_state() and write it back
> in pci_restore_state(), instead of recomputing the ACS controls from
> scratch with pci_enable_acs().
> 
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
> 
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS Control register there as
> well, otherwise a subsequent reset would revert ACS back to the
> configuration left behind by firmware.
> 
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so keep
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

