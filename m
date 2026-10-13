Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487665012B7
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910610; cv=none; b=IdCYJzHlRrSnPIIAqrCWQoCPtyszTYJz5oeJbvAK7kPIEJLuYtU77dhgIrRgicd6un+92sPX5gID0uHOktprpMSdYZSWKRSdVK2p3/4YfBY/wzYB7LqZryXcBVfSVZ5jffZuG4FUMTfepNI46dKcJ+yNS4X3KDiFwagYpvPEp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910610; c=relaxed/simple;
	bh=YYJTbwy0HtrIEhdzcWsomzA4nphoQkU7Pn2YJRhRN3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTrO4/LLN/g5a/L/Gu4UAuxS6tIrM9Z5lWcrAPcPP5VyiJKjK9vlnupCB5GIHoFF68PhyrSu7CF8dpVSW+CwA9OTVpWc/oDl+wUVscSPk51gtkarlf0C/erJs4J1Kidz4+9zra6g3pozVLQbLjIl9VOaGIpyUMk/FZMsxD7FCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VumbfEqy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VumbfEqy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e61ac64ec3so28080855ad.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791910609; x=1792515409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Di8aE6KdoZOnEQFh34NIGAtRDEHWCfZKwuwkHlmj2kM=;
        b=VumbfEqyGQY2UNEEboHXzpsTnpGqHs3tq+0945RKHiuarSR/zkubn69noQDyfLWbDc
         KrR4VahBvsthB42AV99hCeF9aznl9IL1VQrvytZjqphMYDUnZ45HX1YJ3ErSrSCF68Nh
         ljeWb215dftVD3xYbuPbkld2zCq6MNfzrvXnf/VoKrSt17Xy+RCG0xmgwKOJTwj+1HJF
         igV9cwu7N2C0uJW3fVyMW/x6hAmDF/EBIFoR3KGidWS2B8OPDZ5lRJRQpjlKYl2qvbDg
         d9qaO0PnOhrHd4wc/6xwT9tqZbxnxvkGXcnl4H5HRyimcOEuIAbTRMC9ytwnlPQtHD3i
         usuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910609; x=1792515409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Di8aE6KdoZOnEQFh34NIGAtRDEHWCfZKwuwkHlmj2kM=;
        b=p76Iz8i7QTE4XH0wveZzJIbUyz3V+pd2snkmWhU5KSJTihhMug6APuBAqAum8hfi7+
         RHcB/RWazO43Ax74EA0dqR9dUllswAd0mMkFdT+cLzFu1XLGoFJy5fV6KRZOTP6taj/k
         Vc5f0+K8+GcnqRPEF+FhJfkk8NL6USs1gBnr3sBGrS458yOGwkR5eGQJfnK32TyJ3HYt
         Zsl+yjlB2m5ijXJPrVvhJUUurBpsPZbectcU+UYYSwRv2DHc1hEh0XYUwyga8yGXmWV4
         fVB2Gy2x3M9r4sWCR7WnLrdWOp6+KejG3TBT7L7rBBF71KW8qFEBZEa92hVgeHV93bcl
         gS8A==
X-Forwarded-Encrypted: i=1; AKwUvBzkjgINMQJCS/UTvU/FQzvlGExs9DL++YPhYk3QUQuGxtrVB/3kv590u+XO87uaFTNM/KcNvAURpl4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCVpeBdEQmBmkEfm4G0E84LmKOuV8GdOPq9cn+S7mMVDo1tnHA
	obSzv8S6Jgf4zWFhMXP2WsyYGRJ702Odo9poGMBdRQJ/3DY0pv6KTqZr+sPj6j6O3g==
X-Gm-Gg: AYBFou3MZF6T2AjfQnk3wdBJh/60PW3EGseqjiSR7ixIU1tgEaSZFWwdr5bbwoz4pqM
	VMsJ7UiFs3SUlbewn2fOjcSFd6r7rIsmLGK9GNkrDSrOaTyku2H0TEmCjvVGveOWyZCohk50rVi
	NcddeHH551uxvn2uWBwD9pYV+okeox7FDuy245l0zPbeOa21GY43CapQIcjMTrhealADb/rlbAk
	d6TIhnpNbtQL+DEVXHjhv9+49bqIqe/CyH1tXNadoDbU3zT4UnPhJvRwSLuOsx+9izoMl0lo7Yi
	c0O08+Qez25Kknwm5ZTHaDzavjfHBuLrEqZlnIRHl58BPpT5yTZxt/PiaDwN01xa3q3AOGZqm+B
	sk8gpk+J9kWRhkEN/XOLrh8yBhI34i1w5i5/zy+NBrgMoVT3t4YTlvhC+sPcbhmWQh2P13b0anm
	A1jlke1YHeQmmkDISNMZXTm+0qke4x1/8NQhDI8YOAJ0A2cpW0rjAisE0Qyu8p89A6g/VgoRu5l
	2JzBlSUY/xaYbSVKG3Tb6y0FAd1waixkRE=
X-Received: by 2002:a17:902:f612:b0:2e7:c821:3789 with SMTP id d9443c01a7336-2e842ce1b19mr106967855ad.43.1791910607036;
        Tue, 13 Oct 2026 09:56:47 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a04012sm60860835ad.1.2026.10.13.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:56:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:56:42 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kexec@lists.infradead.org, linux-pci@vger.kernel.org,
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <as5iyt9-8btokzCo@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-4-dmatlack@google.com>
 <sashiko-outbox-170133@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-170133@kernel.org>

On 2026-10-13 04:40 PM, sashiko-bot@kernel.org wrote:
> > +    if (READ_ONCE(dev->liveupdate.incoming))
> > +        pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
>
> [Severity: High]
> Does this code risk silent memory corruption by only warning instead of
> panicking?
>
> When an incoming preserved device is destroyed, it is dropped from the
> kernel's resource tracking. However, the device may still be live and
> performing DMA if it was handed over by the previous kernel.

The device is not dropped from tracking. Its struct pci_dev_ser stays
in the incoming FLB with a non-zero refcount, so if the device is
enumerated again it is treated as incoming-preserved again, and if it
never finishes, pci_check_all_devices_finished() still catches it. Bus
numbers also cannot be reassigned, since the preserved upstream bridges
keep theirs.

As for MMIO resources such as BAR locations, they are not preserved
today. That will be handled in a future series.

> > +        pci_liveupdate_cleanup_device(dev);
>
> [Severity: High]
> Can an incoming preserved device that fails enumeration here cause a resource
> conflict?

A preserved device coming back with an unknown header type means the
hardware is probably broken. The PCI core cannot manage the device
either way, its state stays in the incoming FLB, and its upstream
bridges keep their bus numbers. I don't think it's necessary to panick
the entire host in this scenario.
