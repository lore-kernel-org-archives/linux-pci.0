Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955384F402D
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615995; cv=none; b=kHhIm7aw9ZKMcmpQZgJVTd/FnoHueBZwUHxRoTnwCA+Z+UcfRFwf/FYC5ILjY8kTVKvL0UJsfg1jsyEa3afqkkj8mJcqr42VXfanpkuiIzmdvDsQ9hYShvOWrK8ePy2uWas3GXrxCjdiwD2C4nmcvSgHb9vXInTun0zDFwgGcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615995; c=relaxed/simple;
	bh=9bVXZ77Pzbh2OYLwrCoAhJ9SNTHguTxHVRc+s2gfuIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAzY7RCKt3j7R79H0Jw3pbWaTUyL99YY1Ifsw9TEYsvLQAypto9HI3rnOpcO5th5mFILrNz9Px5CWgLMIgj8uJZWonkHMPWk0HDxf2fs0MQhGaZ98al8byCyx69gGD8S3Y3zJhHapBucPT1345RuntoCH0UgRuL+iswH+h4vVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBDq4Hjw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBDq4Hjw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d3b445a84fso3145ad.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790615991; x=1791220791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DWEY4l/bIKaUQ0LkmUfe65oGxH2cGGoTK+zPHQ0IPQM=;
        b=hBDq4HjwxP1eGmrlPhZ3odGGR3Px9kfWs0X0sj4G+s4xv1n4iSLw4UzrLWKbX1MWcu
         +l95p5GNeDwJNkb2CTxKGkGgTMY6OS2lg0xqK5yGrWP7ems0dbFxwmVGGlskcXr/0bGo
         nQZlJxfySz/Ki4xh9+ZlFUm13+Mts5WCKAMP/IdmCXjQF/oVLQzvimqKRhHGzSyfBsq2
         iFIysEZ3S7yHOoWxk4jYYDSWAT65orvKrzsBBw45YXUDCxxPUkjTwsvgJ+73g7Cyu0Jg
         u6Hc5fIUQyylVjn0X6koEM7ca8J5IqxlETirS0AvoIEiGjxztMj5zs3yG5vQxSNcIp21
         Mq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615991; x=1791220791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWEY4l/bIKaUQ0LkmUfe65oGxH2cGGoTK+zPHQ0IPQM=;
        b=dQXhDccO8beBB2qoV4hua2HkYeBhNj7e9BZuv65YiZ60v2F5wJXuKb5Cs/APAP+r0f
         o+r57ahISU7jlvfgRwenpaMHm/lybsWbc0LrnXFWf7kgmj294v9ND/Aht8T/YCbbJqT1
         dszkwe//a+AhmEBVVghJeCpPRDshQKEw/zAG/HpbKbkijUXhEyu+8FweS2xNkKz+SO2i
         sh/r26wCvVbB7O3x0yM0u8heMU87EB0LNW2hAux076O1DBku4//Kudd5vsQ1WV/L0MMl
         nKllvdFuV2FlUwzOTRcj2h66hXApqOjKVwLEXW2D2Exjqhfkubu9KpQPASEEEV5kW61s
         1xQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZk172IW0dISDThZ+d8TniLtFA8UTKO+Q6UetjVFjxnjAcYPjqlw/W/N6ot5xsYmSfqYCEXt1WsQw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSqKlQ333Ze7bS5qb/UnoEeZL46gnpl7irPI0kw+Xg9HPFdjkG
	WH28yIzXpUo+43J3FpR5GrY0n7ugzigNSAwlT9E5oUQcNKcqBEGn/AFcJZq/2Eblww==
X-Gm-Gg: AYBFou3hC5fRTaiJYVCpdJqboAkB/evFQF/ufHOyBn7qUbyC6OvsBgLsZKfhB3ZvUzC
	YJj9SJQKhqbgphuZssGA8JbojZj/4A8LvHV9zmopS2BEkc2SGAjZ3gNpUrH+5my1qpVOcPDCLgD
	L1kzDoYBuh3puSIXU7FIrUcQPvkCWtf9HfUc8rrQTMcN4GoHd2HPx3CnqkHiDN1yO6c5VRHabj8
	e/fiINa09Zn3CQUDYfZfGSqfycZ50iGS9285cOJ+dNIyFfUrfpuWhCdf/G/VxDqJ2IaVk/nDoZz
	V9Wh13CTYslIrlLVwqZ7sQFb/A1Pk6hII75og4lYf60fwFa2JN2jctXmtt8ZpKa5pkeTaEv8wSX
	glp0ZKbPIXETlN+5u7ReYBuPzmoTVANj1HtPUmUn8xr6bJhyauBJ+n3OEWoqI++GcQ4Rxv8kpy7
	1yexkXwFFDfW97NraVyzi0kVpdk3Kv3kVrQZc62hqbihGXPNRCVjQDo9RQ5u2QzSxP7sKDI/mB+
	XmTRRmPS0wp9X/+1RCAY2tvpaUeHooYv95t
X-Received: by 2002:a17:902:f54b:b0:2c6:99be:9dd with SMTP id d9443c01a7336-2dfa6248695mr7310435ad.12.1790615990264;
        Mon, 28 Sep 2026 10:19:50 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858c123sm538411a91.3.2026.09.28.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:19:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:19:41 +0000
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
Subject: Re: [PATCH v9 09/13] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Message-ID: <arqhrVi0YfFNwKuS@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-10-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-10-dmatlack@google.com>

On Fri, Sep 18, 2026 at 08:06:35PM +0000, David Matlack wrote:
> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
> 
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> automatically reapplied by pci_restore_state() if the device is reset.
> If that save buffer could not be allocated there is nowhere to record
> the adopted controls, and they would be silently lost by the first
> reset. Program ACS from scratch in that case, which is a better outcome
> than leaving ACS disabled.
> 
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
