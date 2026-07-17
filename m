Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EF33AD88
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317362; cv=none; b=RUxyuU4kdqjbuSsrvGFeooDfa1JoGpGku3PNZMHHyM1amNSESnuaSbdENmFwC6Yx1jy5woC0UC/inHnJOsiW4vT+7DDsOmDRwdLTQrbHQE9DsPDX/Y3jP3tp72jgAeBV8fLrBPgt5QwltUEKxMfZG85ct9I2y96NstVLcf5ycmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317362; c=relaxed/simple;
	bh=06eki5QMsXCiN4ojqSTErc49FfqPbYMbzVUiMtQToSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYte9d0Li4pBzdF21ieID03uPq325i7SZeN5Lv90LZ+hCXk/tbKP2qkK3UXR6ezyMZWgrCi2m1Jy59MFFPmiP9Mm0WMV90zXPMpU3+Gjn5iTs9WI+HnagCdZYNkKZXSLTKCNjSBaJqFHrO50xiCuSgie6IddqOb/qHVGar1U33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZQDdR4Dw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZQDdR4Dw"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-920f33347f5so618063385a.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784317360; x=1784922160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XwmOrmcqXQWfj6rtFo+8pLNSVXYkj7WYHrCbKkDrWe8=;
        b=ZQDdR4Dw5XwL9NdJyrpOlKYzNpS/obcsaXmYmzaFyLJ2uLH15sWpx9M0DZvFONtorD
         m7qDCshy1fQLyjvF9zU2qJRlKZr0WvPfOBwCpxGl3fAW/FCrGAAXYVA08DQVRhzndP2n
         epvLTMr7rIAUtfIsHy58bL7cy2cFd/mWMzPjwt+4gmAzWjWAxcCpigSs2xce8V890QAd
         rtxPsp8XVD1OjeD2LzFqVfEAa7gKTc16o7ugRqElJphGYSAAN3BndNAzEGbkSDg5P2Xs
         gdCQltzI5JsyY+JKBSEH3jaVxWMMEFdwPhVj6FMEwXtLmEd44Di1PbTCKbqK67TgvROk
         JDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317360; x=1784922160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XwmOrmcqXQWfj6rtFo+8pLNSVXYkj7WYHrCbKkDrWe8=;
        b=snVvU3CT09ahsUPwTuF1P8LkMlmadfbNxU2Zh3qac+ISkpT4WvQNK8vL9EjVZSpidE
         Z2gUmkWCU5SB3OFd42lGaiVkwWx9eBFqLq+aPoGkbM1yaw1710PdDR7fzbt77V7Qzs12
         YqgGKRLpiyIutsEUX/jL8deygnSUxsCxjXtL8hIat3DNO20V+TcNwqG7e0m01FxH40YT
         fLs81t+sZpCTuVLGisNxQATEIgOKUcb2zOIjXKKnKm4d7rr6I/6ruhZBNBhIQCzKkn0S
         HVUt2TcHI8mts8qVXGMNMU6DVRVPONzVUhPrXwVldnTkl9VBNgfvv9ES8aGA/CZFUGWN
         9gOg==
X-Forwarded-Encrypted: i=1; AHgh+RpLJeXQ01/aQJWSSNQ4/BO4KojAoDToVLW1Jf0BD3ELFVdgeApGacRQM8KrtsiW0fT7TpE+3i68uF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylKG/DBv5j0aqRtVCcADQIUFv74KrnYaapNjskOxiBqLg/4WN4
	sb6p3B9G4aKdwhcGDqnXriQd14lnxi8xo6M+Y6ww2MDpd2H4OP6DoAWcvhmL5f6fgUQ=
X-Gm-Gg: AfdE7ckzQ3flgggcp81SW3JkABo0NSKK4E5sHecW5bqqWinpl3aNoJMl1UJpkQ3CAi4
	fXx3cylY7N0bW3SMW18Pz9Iizz8wVLchAwYyyQuEmHCVn2GZ0D4pdNtzL6fSgNwokIBQcDM26If
	1FZFKa186ZRHVNJyvcJIS7Rzu6KL96TVpIEVlCyTeUQyxmwH5g17gLlFPqEQfgmE/PcjmWsO0km
	MU5vj0yaScUm/QAkjH78aFLd5EJKzhoh08QN/fyNMivTesEY9MTY+NAaZpQ3oWN8yL8DvsIYiyQ
	7x3Nhi4X9fOb8+51g1zVl7e3AhHmt9JHmfpFsd27SlWW/fHzCg3co6wyh55uwMAgpXOgijU8B8A
	DQt/FWUvC3HCYZ5QlH1C9at0KKkqPbV1upLr4dP/gku+CJqBZ7t6rGuM9CCWPucaGV6Ycm9FRIH
	4FIcwiIsPZVsNI4dsW67un0PN+exRgUQ==
X-Received: by 2002:a05:620a:4691:b0:92e:e125:55bb with SMTP id af79cd13be357-930b3e9c541mr429942685a.4.1784317359852;
        Fri, 17 Jul 2026 12:42:39 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52dd3easm225279585a.3.2026.07.17.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:42:39 -0700 (PDT)
Date: Fri, 17 Jul 2026 19:42:37 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <alqFcmDsFdjzNZQJ@plex>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-2-dmatlack@google.com>
 <178431652443.189683.17611165218179620081.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178431652443.189683.17611165218179620081.b4-review@b4>

On 07-17 19:28, Pasha Tatashin wrote:
> On Fri, 10 Jul 2026 21:26:04 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > new file mode 100644
> > index 000000000000..899758883dd5
> > --- /dev/null
> > +++ b/drivers/pci/liveupdate.c
> > @@ -0,0 +1,155 @@
> > [ ... skip 50 lines ... ]
> > +#include <linux/slab.h>
> > +
> > +/**
> > + * struct pci_flb_outgoing - Outgoing PCI FLB object
> > + * @ser: Pointer to the preserved struct pci_ser.
> > + * @block_set: The KHO block set holding the outgoing devices.
> 
> AFAIK, these should be aligned after column:
> @ser:       Pointer to ...
> @block_set: The KHO block ...
> 
> > [ ... skip 26 lines ... ]
> > +	ser->devices = 0;
> > +
> > +	outgoing->ser = ser;
> > +	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
> > +
> > +	args->obj = outgoing;
> 
> Nit:
> You could re-write the above:
> 
> args->obj = no_free_ptr(outgoing);
> 
> And declare outgoing like this:
> struct pci_flb_outgoing *outgoing __free(kfree) = kzalloc_obj(*outgoing);
> 
> Also, remove kfree(outgoing) call.
> 
> >
> > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > new file mode 100644
> > index 000000000000..de549016807a
> > --- /dev/null
> > +++ b/include/linux/kho/abi/pci.h
> > @@ -0,0 +1,58 @@
> > [ ... skip 30 lines ... ]
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @refcount: Reference count used by the PCI core to keep track of whether it
> > + *            is done using a device's struct pci_dev_ser. The value of the
> > + *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
> > + *            0 otherwise.
> 
> I believe descriptions must be aligned.
> 
> > + */
> > +struct pci_dev_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 refcount;
> > +} __packed;
> > +
> > +/**
> > + * struct pci_ser - PCI Subsystem Live Update State
> > + *
> > + * This struct tracks state about all devices that are being preserved across
> > + * a Live Update for the next kernel.
> > + *
> > + * @nr_devices: The number of devices that were preserved.
> > + * @devices: Physical address of the first KHO block containing pci_dev_ser.
> 
> I believe descriptions must be aligned.
> 
> Nit: Please order the included headers alphabetically.
> 
> Nit: Please order the included headers alphabetically.

The above was supposed to be right after #include, but b4 had a mind 
of its own.

> 
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>
