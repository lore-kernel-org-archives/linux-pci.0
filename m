Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8264326931
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148475; cv=none; b=ZPZKTg1fKAhXltT6HV9oWuhgNVCE2AIY9ddjaSQ8vNSviN5DPW/XeFD7Xfx5jmcfQGKlSMjMK9NleJVUz+ILBTLNMLGlcbcL/LUXo90rld1rH0uLZWlfnNpKY4XXWUM3y1Q9dsii8G7tDlJSQO/O9ekjgbQBZHvjV5QYTk7z0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148475; c=relaxed/simple;
	bh=nN5n0R1KzYPR6gq9Cg8JAJtOp8uZMPH9g3XcUNvBoaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRTEn3d1KkrJCL3pMAYk+hxwpIdnAEJV9p7W+PBKnicZ9esGQ3c1rW/UmUSKZOpgl6l8twZ8zBfYmrFBUWnyF2xZUDsR+lX0KC/aekvJsZedZa0tdujUkHQ/EHgUkFCN177+lrcWbi3owHXysH+VoEPQXfDtEnlNqq485fkoTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0okHgCK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0okHgCK"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8274a3db5e3so294163b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 15:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772148473; x=1772753273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUrZ9rZ9RlW3x07tCEk7xJ4J4Vz88lZHdKC8XE8Cxsc=;
        b=L0okHgCKUCabiytMNGvBYbMHtStuJdWKE2K4KnP9ytxhmY6s0/WuKJ0p350vQwt7ST
         LimILWhdrT5WLAE4aI25ZKfBq5r+pWEhUow4F6q0Gd4UgpwN/DVmLYp0Yc9vSfiH+OYe
         SahG+vqwdwcCgjjdPrWhoRfiOBsXEOAC/LXrtxgCBLe4TKrdA98/qmBSk5fae0QtMv9N
         ioFWcgtDBYOtn7zY0thjx3jvRvB6yGGmTZuTEZOcxwM2UAdglKK/z/P+rUHQ/TACpelb
         NWgeUMP4s4dqn0WVpOE3wo/ZF5XCvqxfUcGLoJtOvpBOKm2uQSnItmcCggqofWrWX2um
         Owug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772148473; x=1772753273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUrZ9rZ9RlW3x07tCEk7xJ4J4Vz88lZHdKC8XE8Cxsc=;
        b=kvw2JCrsLrSvbp+YKJba7GmL20ZwXRTxlH5kTjdvKg4H76nbPEPp7p8w5lalBtd7nw
         nDqMN0NdKyoSC4h9qFPJQf5UXr1a8hg0RkvHLIk271ge7Q4Ruq+9Bz/LLE3J/G/L+hgy
         Yq7lTSbpzr0Gv6VeHd6dmZdd7AJ+94Hj0bat7IG3nvsGy6jleS3TNLMSwJ58s7lqJdpf
         +OrlJTSql3vDw60Z9TOdJDXBGYL7oQu3Bd0W6KS9MIdgNhA6KNdkAcjNgq0WGVauEAVc
         ZQobPys0szDIi2JE1Fqm/SYofV4s1uggeR+ZmgSbN7zQNYI6QJAM+8ZoxAOV1wr+Nbz/
         zdBg==
X-Forwarded-Encrypted: i=1; AJvYcCUc4ag4o57GKCyNrAAtDpBx6DGV5ze1uY6p35aMgxgY8fYaaBxLNuyaXf8qyB64UN4FsAeVIAG/4Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEc7EUxRxbvC20jEh/gVe9tR8fwZuApbF58SHZB8mcI22P+2B
	p/h6ATYeefM824lPpohKRm2mr/VD1567FfJdzUIwN3z6S5iTo8LLilWjndO0sriz3g==
X-Gm-Gg: ATEYQzzTTcEoxs4QR4Xjvv9IvoUQ1LPCR54m+nvfsY0OuJkcZ+fQ6klm3zDpWcXje/w
	jHDTW/l+0HccC9Xlmw4OTmJYw2K/NJHAuS4CFPMDaDELXwBoFtkxiGRW/BY4/ZlTq0krxkQjjUz
	uBJpM1zvaMwEeFnbpaIQz1xT/hHjtaAuKt7qjSPywbzQQA5W983xb7Ab0IDo3i3xjxRAz9HHOWx
	IaYAmW1XBQi9oOfCRIcJeqmmXQx4Jac4EDlX/40kxnp3cUjWYpCGcnzzuCkI+Jm0xlD0mJexl06
	D/rnIDn8F7taNsjSW1t1Q6AflK2s/STA8MWYHQC7nGOWEz33V8UCaAx4zRpd+KnfCr2I5YMoy0u
	Bk0yGdeaHUqZfzQwGHZBH9a2W8mDGI2Fqn1b3nL334M8zamPOElFikxaHFinuZbvqfJMl/oZF0b
	swykLCVPcyMRMtp8BS8AZVhwnIU3VdZRoJglj4Jrp1yKKOaiuwf01U8RjVLv3qgRYxdKHlrbNf
X-Received: by 2002:a05:6a20:1585:b0:38b:e9eb:b12b with SMTP id adf61e73a8af0-395c3ae6d18mr701611637.41.1772148472659;
        Thu, 26 Feb 2026 15:27:52 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a03fbsm48080705ad.43.2026.02.26.15.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:27:51 -0800 (PST)
Date: Thu, 26 Feb 2026 23:27:47 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	 =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 08/22] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <aaDW86eWuQLZ3cfP@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-9-dmatlack@google.com>
 <20260226161512.532609ec@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226161512.532609ec@shazbot.org>

On 2026-02-26 04:15 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:55 +0000 David Matlack <dmatlack@google.com> wrote:

> > +	/*
> > +	 * This device was preserved across a Live Update. Accessing it via
> > +	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
> > +	 */
> > +	if (vfio_liveupdate_incoming_is_preserved(device)) {
> > +		vfio_device_put_registration(device);
> > +		return -EBUSY;
> 
> Is this an EPERM issue then?

I was thinking EBUSY in the sense that the device is only temporarily
inaccesible through this interface due it being in a preserved state as
part of a Live Update. Once the preserved device file is retreived and
closed, the device can be accessed again through
VFIO_GROUP_GET_DEVICE_FD.

EPERM might lead to confusion that there is a filesystem permission
issue?

> > +#ifdef CONFIG_LIVEUPDATE
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	struct device *d = device->dev;
> > +
> > +	if (dev_is_pci(d))
> > +		return to_pci_dev(d)->liveupdate_incoming;
> > +
> > +	return false;
> > +}
> > +#else
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	return false;
> > +}
> > +#endif
> 
> Why does this need to be in the public header versus
> drivers/vfio/vfio.h?

No good reason. I'll make it private.
