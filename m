Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1061D7E5C
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665617; cv=none; b=gwtJxPKP9cTb9KJ+p3uRwV6lA963Zea1FggMxwKCjI0hxEZy8fEzAvHcxKs/gPFUMTueqP1AB9GhGxZmY4N5nHav49yVTpoN5PJi8mCwDBLEk9ojXfIQNoGNrDrJHF2LSZ8KWu3q8/cZfcss1FhHRStnlnq3FVuOCkhYyT4bk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665617; c=relaxed/simple;
	bh=/H8dJRCH5zM9HYfg/wUUk8/wg39GT4PZntRlJNqT4U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdlgF04q02p1MIjKuATHDTrwLx/xoOF+4gxN2XsEPRQ1Rao043Cnsh8Hr9/hEhzg8p3XsyTZ16zWMm8a59UIZ1wJFI/1yskPkQrM9nfqN0dosghhqJ7NJL/UKB/XMxV+zcYmQZUcyer288WiVIFvi05tLB7hux5AQTnAdXUw9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+DoC/yp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+DoC/yp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc891373e0so148124465ad.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784665615; x=1785270415; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bht7YFPW2nLJyME+XdIc/6Xfh+QtNInRSN0Il3SMOm4=;
        b=m+DoC/ypG33bi5gLgB+FpNvfgN/3tj7LmmPCDZmkQXuoGhpqlhuC3+XwW5Xhe1ShZW
         7rfKZx+37q5tSOiwFjfr6NlfuF6AEg0hw96SM/Yc+LP+UqWaJDw6ZkZnmkr6lwrtE2up
         MHo13g794QyzFc0hY0uxfGJ0hY2YpXyx6/1O5AsS6J/tRxhmSGaUFP+mnygUTcojB+JR
         6AHquuplaeRTvIK1sF6fCcxSciUle6xiNhQCMAH2wPNV/tC4U88VeiCZacrU3X9iR5KA
         70pgwYahckzw/sP1JtuHuXYgSV1/x/+Bc/+qOD/1n+5I45XWR0rlUxira8YpNZrqvXtX
         wjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784665615; x=1785270415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bht7YFPW2nLJyME+XdIc/6Xfh+QtNInRSN0Il3SMOm4=;
        b=FAN4CK8XycYJKfPXcKD+0V6XOs29odjVaZrx9RnOVS6rZVMT06mWBkWIBfRm5IRq3+
         JinCEPuvulfH6RvTYAmSxGnFvxLXJdOAFmTQX+RCt3I8Qf8dD1KBQ4BoxFDzrApZuo2x
         WBcmP4shnDbuN7AzURWqevV5A2psS84ZeV0vLQFuu5OCuRqOcq9KQHKe14qwMGzGl1Z9
         rrbCwYfVSyQCp6qLKUzobG3ngeYwn7gQIWNwn84DVqo+fgXoHRcU5k/Fc+khkVsRrYjt
         k+6MuKmtnbjWmU77BvC0UkQUJMPuB69jDy3pEJl/cCK0IDUA14UgzKJ7lPHHJt8PCmIb
         ReQw==
X-Forwarded-Encrypted: i=1; AHgh+RrR/dXasTsnCDkIn6uxYyWZoiC8Bt/1OC3c7xET30hzfXN06s7M6w1ddXILTg4C9UYUtYWC1xVgO4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVwAPb/dMhnuvKVmF37BJgg6fZf3lzdMdzGZqrlyYMZGuVI40
	jhngoQ3dUkcEfmeNDFS5hn0AyISCNY94gY9po42OG/CB9+a30+OX0UhUzx3AOideQg==
X-Gm-Gg: AR+sD10KeEy5RJRUABwuPHgljx6Bzz/DVPjaWN9+7wM0+qv2FJIANY97KH5TxecxlEo
	KYV0dqJmR3DQRSQsQLaJqOePK1HiiltOPYna6J1/zS6rnZOVDk+rL6S87lk6VplNBBkDwAGr2Zm
	sW92yK4Gx8XOj287o7DofRG7kvURfXY8O/q5B/qprmUZGlr1KvtO3h7WaKtiOP3AOfAJrYk5DMe
	cyRa69exQjKG+/tR+4DnCe/Jw+5ZXYKhgJRqPrjel4T6IZjxOE+L0W67+qI5IwEFG8+meuk/Y7l
	Qny9GHaRVQ3Uffj1DRioogtll788ZA9kupO583GBQ0Q3LABGol0tIhIrjCrZWEwjT4wBraBZi6l
	GfnGql3gZf759CCiZSYZoxuyeNkfGdKJMMHCT/lS5Z8GpJQI9o+sAexwqLjwITtoBd/q+lt8jsD
	mC8PufcM64lUY3AMvEYs4anL1N5FAzYV9R6f33tuHH
X-Received: by 2002:a17:903:4b43:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2cf3481d1b6mr200020005ad.2.1784665614286;
        Tue, 21 Jul 2026 13:26:54 -0700 (PDT)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efde5cfsm2738235ad.31.2026.07.21.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:26:53 -0700 (PDT)
Date: Tue, 21 Jul 2026 20:26:50 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
Message-ID: <al_WCh-G-H1kDU1h@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-10-dmatlack@google.com>
 <178433098576.189683.2364970585754668266.b4-review@b4>
 <CALzav=eZYfYYKAGEzk4TsGFLp1TPb2iFePNmqGsjX4jEZNJ9XA@mail.gmail.com>
 <178465783370.437204.17382376546970842455.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178465783370.437204.17382376546970842455.b4-reply@b4>

On 2026-07-21 06:17 PM, Pasha Tatashin wrote:
> On 2026-07-20 16:19:00-07:00, David Matlack wrote:
> > On Fri, Jul 17, 2026 at 4:29 PM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > 
> > > On Fri, 10 Jul 2026 21:26:12 +0000, David Matlack <dmatlack@google.com> wrote:
> > >
> > > unsigned int    ari_enabled:1;
> > >
> > > Sashiko asks a valid question, what protects other bits in this word
> > > during modication?  At a very list a comment is needed.
> > 
> > This was my reply to Sashiko, not sure if you saw it:
> > 
> > .  pci_liveupdate_configure_ari() is called from pci_configure_ari()
> > .  which also sets dev->ari_enabled=1 and is pre-existing code.
> > .
> > .  If writing to dev->ari_enabled in this path is indeed unsafe then that
> > .  is a pre-existing bug.
> > 
> > I figured that a comment wouldn't be needed for continuing an
> > established precedent (it's ok to write to ari_enabled during this
> > path).
> 
> Overall, I agree that if there is a bug it is pre-existing. But we 
> should also take opportunities to improve existing code and make it 
> safer. In my opinion, Sashiko raises a valid concern that is not 
> obvious, since there is no comment explaining the access of non-atomic 
> bitfields in the header before the struct pci_dev definition.
> 
> In this path, it is safe because we run inside pci_device_add(), where 
> dev is brand new and has not yet been added to the public devices list.
> 
> However, it would be great to:
> 
> 1. Review the access patterns to ensure there are no concurrent writers 
>    on any other paths.
> 2. Add a brief comment in this patch right before setting ari:
> /* Safe to write without locking; device is not yet publicly visible */

Ack, will do this one in v8.

> 
> or:
> 
> 3. Create a new separate patch that adds a comment before the struct 
> pci_dev definition explaining the bitfield access pattern, and how 
> concurrent writes are avoided.
