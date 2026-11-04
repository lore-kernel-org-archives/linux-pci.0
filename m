Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813455;
	b=heyFA0Zj0wYHfUpq8DVKt/iVdjMVjHFUvHHSdvq2mAe21h/dp0ehp4S6yhiNAzPCqTPJ
	 QMiYBAWuKZAbCXRMV+K5hmevM8MGgRwLj6sUmkvFwtH/J5uvpncNCUV/WRO69HMKsayPj
	 m6t8yGkug3Hax0yJcf/9Yun7KSShn0o/yomxbj3vk22UBVv1xrnEGoW+hUN3+WUormHu1
	 TEA5OjLPVt9a4kAcutJ6X3uLs2Krlk/WYpCGy5b5JBHOjCDz7YKWxvOOQuu62ngq0Qbnt
	 YQ3w7c6mkvjxPivV4YIZXIfmOX+ozWsJTqQrP1dsWkRgYg7zMfF+gg33l61qz5EBXZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JCJ1yR0CfKTTeAdrBXXTTC8A7lSXPL0k15OHXIqV7No=;
	b=KIkXYpBa+w6OIryaIywet6w+wnpDAR0ljjhRVWtnXP4enHK/VyuAp6RbHEEFPAyRJOgp
	 dedDPV4FNdFqMxh0ns0/49GNRZbOvKjbtr86ZuWkNhMmn98yd485fdVq5yu5kgY7rYrxF
	 Ox83GAlQNoLKT9rvSda92FHxUWPdGHW5sc5S9H39PZEsb+YYcbj506szRhrvq4bIu65xO
	 qlOLjIF94sHOGmLMC42/ACfplb65vYq1DNSzeFyU5fF2kmUmOIA6GqSyIGas9q/ZBtud5
	 rnW46mnEZDzD1twfeUZSM8wEZ5Tb3l79Zyhvfirm7BGIde+nUC4ZJL3oCsm9WXE6uww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GaeUFhkz;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963846082BF5
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 963846082BF5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GaeUFhkz
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f22a8515eso94763285a.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793813453; x=1794418253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JCJ1yR0CfKTTeAdrBXXTTC8A7lSXPL0k15OHXIqV7No=;
        b=GaeUFhkzvthXOhoetcHKVcSh6GccvGYYFWhjQ/L9ubqCRHFSf2lQvLsrmP+4cXXQJj
         bkvY4nW8eADZKIRNNF9g/ZYcjDob/0eumGRWsqswZv2s1dr3ca5t1Rtbv3my0A79zxLi
         C19ZY5nG/XTxMAKSVXecv5ODRRBcFqkRsGNVNJ/PzWp3uF8Gv/t/YP5dfm3fqhnzDMP8
         VwKo8zX/uwcrJsLXkE5FOiUE2b578ou5aBtw/VFtBqGZ6E75ytadlrKNTGCxg8fROA/A
         1MetWdj3jtEYdhsH1NQ1p+d14viRAIfADFpSycN8dtR5DnhLpPcqAJWfSimw/vJeNCkX
         pPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813453; x=1794418253;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCJ1yR0CfKTTeAdrBXXTTC8A7lSXPL0k15OHXIqV7No=;
        b=WIPAgGLAj2ZWEXsoaWnP972FvbXglKtBNEVk8hhYS8luJtG/bTt7/RUPpYt7D/WP2a
         nGNHdjmUOd9aBavjGkxowl5eG6Q0Uhe5tIa4t9RTmsQe1L7yFFWONhuK8p1ZWsR6A3kk
         8s3K4idXI8AfmJNs3kQpKWDzscrp8i0ADDU5ouRV6Sh4cNqj3MAr7NT2Hpw8bwgE3bby
         kyxAmuADr2DLvggmXgjKqyzrbdNXWGSciRuj0I8I05VsBOlw9CqXo6ymlJfBCkUfJhSw
         RojCAmDnOYDGQWcH8KG1iQ8t78uBaFEx+7bxowFQhHLMhBUHfTUvL3gsK20mDvjhjdWN
         aivw==
X-Forwarded-Encrypted: i=1; AKwUvBwVxr4iXmFDaoAeOh9XZStaD+vTMU0Rc91PPtoxUhqUkCVzvnkRZfn696o/kdkv4mL2hvFK/+qgtGc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+YVi2Kfg2N/25ixmD6MVLoOckZBkaWxpSXPMjimsHIsmARJJM
	jVe1WvvjhHPMupJgUKlbcNe6qHeWF0psRQgIpW/IJXFomUEL8YgkLQkyWDnpQ0H/5UU=
X-Gm-Gg: AYBFou2xeYgzNsl+vNsjiLJ0gKFVINS62bvGr6Ol/GiNUlU5aG2IDm7vGUxuPG4ln/q
	69TOOg9v5OZPXKj4rkuXmrI/5AlKHicosyAfMx5npo0j4SN63lGFBueNqOd0PHcqB10ts1zPzq/
	CNDsn2SKzreNbwwSE2wsi60NmKcjA47hC7cmt4ZfkI6fOcj8A0oOe5ctiIgGLVZZhkyVhe/jSGz
	GoEVrOYBvoOqMHW7YqcpNLRjxbzGa7NrCx+PI2FGljm+5nsB7Fr4wyputzhpKT/MrSlr1ufDRDK
	T3ibw392zoCkpYho624n8rgnPhu3biMQ5ex1C3vKR0nti1i26HbO9aNyJmKJJs6zoDYTDb0mwnQ
	sJ+WXOuWXJVci8HVgevB/+aZIHiHbPZn8Y5VE+lU1F8/5/SE3pcXW79yW9YqLWHZUaDqiweDQvv
	cRxvzhiae9AgxqR0obAgxRc3vadhfkzeWfEkcw3qFX7rS0kEDQQYOYlwM/KMDtByDH+iF6O1wEQ
	kCSZqmZdA42HUY5JuDlJICE1oDLFiwlIw9D9eGOEoZDCrcZCWeq+dRUj79lIlmhwg19fZaRceuS
	vu5sVpItwnG+gaVSpWItn410RoBodTbfdFdx8EOANOLDU4nqZhPY3VCheAQTivlmgp42a5HayY2
	euuHyuBMW+Q==
X-Received: by 2002:a05:620a:254a:b0:93e:fd69:9a93 with SMTP id af79cd13be357-944217965b3mr2850479285a.31.1793813453137;
        Wed, 04 Nov 2026 09:30:53 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48316f4sm251472185a.25.2026.11.04.09.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:30:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOep1-0000000GrOz-145A;
	Wed, 04 Nov 2026 13:30:51 -0400
Date: Wed, 4 Nov 2026 13:30:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukasz Laguna <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, michal.winiarski@intel.com, djbw@kernel.org,
	brett.creeley@amd.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vipin Sharma <vipinsh@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 00/13] PCI/IOV: Improve reset handling with VFs enabled
Message-ID: <20261104173051.GV3889730@ziepe.ca>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027194905.GA462134@bhelgaas>
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
In-Reply-To: <20261027194905.GA462134@bhelgaas>

On Tue, Oct 27, 2026 at 02:49:05PM -0500, Bjorn Helgaas wrote:
> [+cc others interested in VF reset]
> 
> On Tue, Oct 27, 2026 at 05:04:33PM +0100, Lukasz Laguna wrote:
> > This series improves reset handling for SR-IOV devices. Today there
> > are a few gaps when resets happen with VFs enabled:
> > 
> >  1. VF state is lost across PF reset. The PCI core saves and restores
> >     the PF's config state, including its SR-IOV capability, and the
> >     kernel representation of each VF (struct pci_dev / struct device)
> >     survives the reset, but the VFs' hardware state does not. From the
> >     PCI point of view, the VFs do not exist between the PF reset and
> >     the restore of the PF IOV state. Their config space is lost, and
> >     their drivers are never notified about the reset.
> > 
> >  2. VFs are prepared in the wrong order during bus and slot reset. VFs
> >     are handled like any other device on the bus, and because the walk
> >     is top-down, the PF's .reset_prepare() runs before its VFs'
> >     callbacks.
> > 
> >  3. VFs on an SR-IOV virtual bus are not handled during bus and slot
> >     reset. The walk recurses only through dev->subordinate, so it never
> >     reaches them, as such a bus has no bridge. Those VFs are reset
> >     without being locked, without driver notification and without
> >     config space save/restore.
> > 
> >  4. The "bus" reset method is unavailable for a PF with VFs enabled.
> >     pci_parent_bus_reset() accepts a device only if no other devices
> >     are on its bus. A PF's VFs typically sit on the same bus as the PF,
> >     so enabling VFs makes the PF fail this check. The VFs are in the
> >     PF's reset domain, so they should not block a bus reset of the PF.
> 
> I want to hear opinions on this part.  I guess it's obvious that VFs
> are in the PF reset domain, since resetting the PF destroys any VFs.
> 
> But I don't know what coordination people expect between users of the
> VFs and the PF.
> 
> I think people expect to be able to reset VFs independently so they
> can be assigned to different VMs and be reset without bothering peer
> VMs.
> 
> But whoever owns the PF can reset it and all the VFs, potentially
> destroying any VMs using the VFs?

I haven't tried to look at this series, but IMHO, attempting to reset
the PF without tearing down all the VF drivers is a big topic.

You need VF, vfio, VMM and guest drivers that can tolerate, detect,
and recover from their HW simply stopping. Without breaking. That's
alot.. mlx5 has some code to do this, but I don't know know who else
did this kind of RAS work, or if even mlx5 would survive an unplanned
FLR of the VF..

That said, if we wish to allow PF resets while the VFs are still
existing the quoted text looks fairly good to me.

Jason
