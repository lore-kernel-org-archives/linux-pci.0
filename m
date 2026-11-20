Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185889;
	b=Dl3B3Ypo8iIQfyYjgAZ8Eup9ej50eeqyneGS1flEQ3dnT+Tc1qM1SiLzqvNTHsW/pxUm
	 hEVJYPqdK7c4rp2f0x7FmIu02i0pOzOG921c+VEiIDrST4M7HPCmYGcUAY7mzvtyPM5/6
	 a4QD59DuMkXz16Or3QGTQIGh0ExrHCSORFGfZuwGJFB+j1AiUYpRBFFS94LMspup1xsrD
	 AUNikENv1urujF8Yulycu/pQBsvitx/aagYg/sKrfzhbzlODMfq6rsAAo/FuiWl7gmC8k
	 c1kG1HxR/Tk8AiTzwu4BNWbE4OhOMqF9TF6FI2kz6UkzRlWBHI33dfu6lJPdYSzpguw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UAmEuVaLj2um1QYSHCqaR42KS0RtEEeYHE8D0ahDr3M=;
	b=2dDz6A9i7Y6qu+sWeHgaQQbMSVMpFHCJK3X4ZUjoXR6dPm7Q+CYxYwkjHLU6sr5kiqe4
	 1CCJ/b6uKtHMMTqVK7mNIfC+0UkVp+Wmao4RxRbGDI8NJqf0AfBkhiLWhd8LUb/AyKH3v
	 pOf1dEU0XhiDEs1w+rILuzr6wwa2hu7FDG13wfoKj2436zAEOqPmRJaBHFgsiWogJIjWT
	 ByhvPkx4IIhQ7Re7oUDcZ6SWXWip9TYl72+TLWXRjN73mAMAL0rwDAc+sUZD7fKInzAIC
	 hAZrJqt6mn09jA8udSl6DZIfq6Zq/nN1IdTLzMmZyWxT8WXp2EefygREMvPfcVZUt+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UafOjWj2;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679560A2604
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 14:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9679560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UafOjWj2
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-533202fe429so308691cf.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795185887; x=1795790687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UAmEuVaLj2um1QYSHCqaR42KS0RtEEeYHE8D0ahDr3M=;
        b=UafOjWj2qya2A4DjUwYc1dvmiVY3y7Yj84AgIaf3lwE0VabIzpOxlh7v0dWgybaoRL
         f+aEIbwPwYlQLKv7D3DVSsUs0eD+0/W1mI33E7/+1DoAhkbeKlWXpPAhmzPfaTLMDfU4
         osHhLK+HYgmOncAFpueqSfQ6v1hud4mzsTL2cPBHj91sHw/ySocCzFWPBKnbqJQAGNDZ
         xHZLzqv3XpioTqUPROOKnkyzw2Km5eHTcu2FBj8GTdQVHdVJiyDISBZoNV/K7nqDfV/a
         vtYdN1Jv8PFRaEuA0eiZVJuhAYqD7JedknH3AF/gCHF4iJL5NAyOUZT+BOQlH6aFMGRe
         sawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185887; x=1795790687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAmEuVaLj2um1QYSHCqaR42KS0RtEEeYHE8D0ahDr3M=;
        b=Moh1C/T6RS3ei2Yt2vuYQXq3AhQJal227Ek7hwJZqLX1BL/gEjRgVGmOxSUyHWSicw
         Hkr/k805aqeOGVUrShth3Bsevm1aiMOtwhMX+5X4S0LqbayLJ3lGYRIOfQ/XZG/8mCYA
         NqrISP0DVLHZoQPSeFslrWgKfOlYkWMkhxAzBq6ELFeX34X56USADPmmX8+t445LVb+W
         dh+EFUs0ds44EOB8xstzn122jABb6E9vDdQyFEOsv+1Sk83o9enl9kxEq91fRRKc+lgC
         6NRH65U2aXFLUQiQfB7q7nXGIebalhKuXL3/06qvsouuGonDCxxMaYyluWv4dIO4DvWB
         Q60A==
X-Forwarded-Encrypted: i=1; AL+hErGoWCJeYF6U3gB/+fVErgem0kn+l5QKOV9miz8XF7w3YJuEv2O6iYaYU+YksolZIN8UCBMCfscLBKE=@vger.kernel.org
X-Gm-Message-State: APuU4Z98wdh8KHMW45QQR6JAFwZq4vsJ6CJ57/OBTEgLgCkoyDJMdwhj
	7RrSD8dl4EbuU2esBi3x8vLu7w+kAKmUqsJQrB5QGtitlpkOqXGEf3VOwuKXWx24YQ==
X-Gm-Gg: AYBFou0hOpKTUw8EuDk+1elHaZs/zWEBssAwfS7/YQAE7cY+A4YKLDq/MN0IRsKv9Yk
	hn8zqXjy9L7NUugH1WNQqr9HzZQI9emFbViyT3HNnZw54JqWTrWvMByFRIylkk3p8jCMUsQKQPY
	26uzmdMQHx/P1gd/O70XWMrVimGfDeE6WDi/onnBt6T+VSe9tJQV16GD5wuJtULCBiJrppVPlUD
	//Ky1oqPzLwQNfMmTKHg/Qwxd7OjaK6ZpqSXUXl9mbi+R55LsA4u4g0YcDn2vyIa5mlfKf6fpse
	hpVlZYfF5y+zTohc1OGm78LdXVquZ/+kEYNSeoK6b86u7Yl4kEKd+O6ojtvApdS5oRy1yfGDYdj
	n8ay/qVUvXifE2vMm9tWwphfEHD7m8TqUVZslgTPlt9QoV6U6BvMatwX7GSRnKCjPY0Kr9T//4G
	1bSMScFOmS+MoEJ3hduC5ho80S15nnyt1eB13Pr1vqFU7+ebfYPFnYS3sYznCuFPQ9KWpJyn+fO
	YDP9tedZOsy/LBQLHuDZUgUy6V6fwmRne5XPMRIUUiS2+FoZsq0A7kiBXYaua4BK8MhhnQlG8CT
	Ti2amlWN1Z6zedf2Jqp97dCRkXDSyALy3W81OfWQeIkbIz7BfHV5KHqSkTujccEkFFaB/ULsSUw
	93Mr3FeD3Qu3F
X-Received: by 2002:a05:622a:2b07:b0:536:6ea4:e6a0 with SMTP id d75a77b69052e-55d7a35af5emr17844321cf.11.1795185886849;
        Fri, 20 Nov 2026 06:44:46 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028c80dsm14013017b3.13.2026.11.20.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:44:46 -0800 (PST)
Date: Fri, 20 Nov 2026 14:44:34 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>,
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
Subject: Re: [PATCH v11 08/13] PCI: Save and restore the ACS Control register
 and Egress Control Vector
Message-ID: <awBc0m4oW9nW4hgX@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-9-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118223704.3286085-9-dmatlack@google.com>

On Wed, Nov 18, 2026 at 10:36:59PM +0000, David Matlack wrote:
> Save the ACS Control register and the ACS Egress Control Vector in
> pci_save_state() and write them back in pci_restore_state(), instead of
> recomputing the ACS controls from scratch with pci_enable_acs().
> 
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
> 
> This also lets a later patch adopt the ACS controls established by a
> previous kernel across a Live Update rather than assigning new ones
> through pci_enable_acs().
> 
> Save and restore the Egress Control Vector as well to keep it in sync
> with the Egress Control Enable bit in the ACS Control register, which is
> now restored from saved state. The kernel never enables Egress Controls
> or programs the vector, but the firmware could have and they need to be
> kept in sync to avoid changing how P2P traffic is routed.
> 
> The Egress Control Vector Size is a HwInit field of the ACS Capability
> register (PCIe r7.1, sec 7.7.12.2), so read it directly from the device
> to size the save buffer in pci_allocate_cap_save_buffers(), similar to
> how the VC capability relies on its HwInit fields.
> 
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS state there as well, otherwise
> a subsequent reset would revert ACS back to the configuration left
> behind by firmware.
> 
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so don't
> allocate an ACS save buffer for them. Keep configuring ACS from scratch
> on restore for any device that has no saved ACS state.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
