Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3E18A6D4
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153486; cv=none; b=aeoPiIdYDhZbpkXst1f/aAMaEPebUMmZEr7jTA44EFxmtDDI1LCiX56SZkyru4zT/G3g3s8OQV9i7Dy+Wpk1N1C1PgJdT9QKMJY9LZC4f11ugJb+94kjINzU39ISi6s6gXtWmGXKM9nJO7IwE480MLwTeyLwHd/bWAtGbPxdlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153486; c=relaxed/simple;
	bh=RyZXx/G7qCicaZId45D0cNgeQ8TX0mKD9axtH69slQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUaVDRTCdyiSiNos1c83sLAullGQYntSRCbSWQf6W5rndj8Sa1ULp2k+MjHp3VxNSueXXBPvdsVU84Sck6l6GJi9uGZ/hJ8ON3Xoe5LviX8pqhYCwr3icwq5h0gghWvFQQZE7nueqCyk6oLh3/J9vXqbagtyZthoTHjUE6Qd5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KV+yYfL3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KV+yYfL3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab39b111b9so7325385ad.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 16:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772153484; x=1772758284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbrSIpDE3Y8TNhyTW+6lYUs18ku3UAynLvTznEtk/Vk=;
        b=KV+yYfL3RSTVSGk8zPgiMYi1QxoJ4iyFJaBlfRxKrxMv2CCbZKiRK/6BH23MWBqsZS
         rF+F0m+o/yWe1FkKbp7TFSVIO6HG6elJYI6oXqrqx3juZ51qFzIswmQIAB4zgwZbKaEN
         /9B5wVem+oXu9Clr+wFdvqzS+s9aMNZ7XOy+5u0PMl9GXMvX4YwZxxzWRpxce/ygotv5
         GHKd+TfodlrNdiOKX9RhHGqNHFTr3CIKkYcd3SXTE9Yrv3Sgp4YKcoGDY+1/A9oXu3wi
         aZ2AtafAcT3gU2/tugcMopjO6eJgXysOzMHswmwzfqhzXh1LPwCtbxmZmWF0LTT1NQaF
         vqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153484; x=1772758284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbrSIpDE3Y8TNhyTW+6lYUs18ku3UAynLvTznEtk/Vk=;
        b=uAkoS0m5wv+5K4gKgtOKYY+atUt8glnji6fPmsBnx0J6JrjoGR3phxlVRdR0sVDVqz
         pICOnLKodErRByainks3RTumfDH1xVliPL4PfmBU3nCAL18B6FYTxkXzsn6T+oUTkC7l
         XSRhmzymJkfeU0ZIjy7iKnkZFMsrYubNa1R0kguW1Qe8XxW8hqSGY2V8GVczzVFNjrf8
         Z0oPZBjV/jQzj0u0P9dWE2czok0ikBVUwgezPMwM/y1PGfksiuKAct03ta/IVfV0JbOP
         6IwEBKUJldZB40F+eSxBjHwNItZFWwUNH9va+dJDvxFlRhVR1LGEl180PcpZ30mBOMEK
         BYUw==
X-Forwarded-Encrypted: i=1; AJvYcCVox1z1TAJSzM8AeAX9LHjr6cJfHM9QnwDJvtpigfCORlTZDhZNLgCa7SS4dO7y8T9gATuk16YI19E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtADs5QDc0K4LSlMhujDc8I1TjvM5GWsv2BfvCa0zs87oD/48/
	RSxtmTUr8H2YXFGeZzsl5pGzmpqT8rZNPW7M/HNfoHHj9flU/dHaYw4LJc9xBmOvZQ==
X-Gm-Gg: ATEYQzxCTqDNIVwTNuJ0ZENLDabBjmrAdDxcZHLq4BVNoTjOd7LtRGqzw8V8m7NGY8I
	A4dC1dRJa45wp1BYdIutyc09HMVX5nSihMkSvJOmbusUAt+mgKReQGoh32Hgphw8a7XIZdqD0vl
	aKPV6HpwosnAiKKlPxE/ppSO4SGn6qL1XYmGkWKG8MCS2OH2p2I9NYQBaQRzhOYHKTiFXXCmigl
	et7tgS/O46ZdcadKTUOy73vNRqBnzbpxea4Co5jxfrwZ/TilnWc1iovUiXx4QgYw3xuku3/Dl8t
	ZugmTZqR2Vha15rl3eWNrOs9BM1grEq/IhR+1ipLIrKMuKfHbrE6GwEl4QpGZlnQyUmMTCdFMVQ
	OghknJiTatJuBytuOoa4ybH8ySkB1hJppPjqC/arpmmf+FvG7zXyRaYdTlc8z6doDkktUH4Wpoj
	k1OchGa2Y9ryZNf3usnslvyPUnoXLis6YU6igfZ3zvPeVxJjvJ9CE2YKQffDdfzQ==
X-Received: by 2002:a17:903:41cb:b0:2ad:ba04:40ca with SMTP id d9443c01a7336-2ae2e419430mr8325415ad.25.1772153483265;
        Thu, 26 Feb 2026 16:51:23 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b974csm34254135ad.65.2026.02.26.16.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:51:22 -0800 (PST)
Date: Fri, 27 Feb 2026 00:51:18 +0000
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
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <aaDqhjdLyf1qSTSh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226170030.5a938c74@shazbot.org>

On 2026-02-26 05:00 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:57 +0000
> David Matlack <dmatlack@google.com> wrote:

> > -	/* If reset fails because of the device lock, fail this path entirely */
> > -	ret = pci_try_reset_function(pdev);
> > -	if (ret == -EAGAIN)
> > -		goto out_disable_device;
> > +	if (vdev->liveupdate_incoming_state) {
> > +		/*
> > +		 * This device was preserved by the previous kernel across a
> > +		 * Live Update, so it does not need to be reset.
> > +		 */
> > +		vdev->reset_works = vdev->liveupdate_incoming_state->reset_works;
> > +	} else {
> > +		/*
> > +		 * If reset fails because of the device lock, fail this path
> > +		 * entirely.
> > +		 */
> > +		ret = pci_try_reset_function(pdev);
> > +		if (ret == -EAGAIN)
> > +			goto out_disable_device;
> > +
> > +		vdev->reset_works = !ret;
> > +	}
> 
> This could maybe be incrementally cleaner in a
> int vfio_pci_core_probe_reset(struct vfio_pci_core_device *vdev)
> helper.

Will do.

> >  
> > -	vdev->reset_works = !ret;
> >  	pci_save_state(pdev);
> >  	vdev->pci_saved_state = pci_store_saved_state(pdev);
> 
> Isn't this a problem too?  In the first kernel we store the initial,
> post reset state of the device, now we're storing some arbitrary state.
> This is the state we're restore when the device is closed.

The previous kernel resets the device and restores it back to its
post reset state in vfio_pci_liveupdate_freeze() before handing off
control to the next kernel. So my intention here is that VFIO will
receive the device in that state, allowing it to call
pci_store_saved_state() here to capture the post reset state of the
device again.

Eventually we want to drop the reset in vfio_pci_liveupdate_freeze() and
preserve vdev->pci_saved_state across the Live Update. But I was hoping
to add that in a follow up series to avoid this one getting too long.

> > diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> > index 350c30f84a13..95835298e29e 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/types.h>
> >  #include <linux/uuid.h>
> >  #include <linux/notifier.h>
> > +#include <linux/kho/abi/vfio_pci.h>
> >  
> >  #ifndef VFIO_PCI_CORE_H
> >  #define VFIO_PCI_CORE_H
> 
> Wouldn't a forward declaration do, and the kho/abi include can be kept
> out of the public header?  Also should be in the previous patch?

Will do.
