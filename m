Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516616;
	b=343eaeUAEjTuyO19T9Qb6ImjNSk39jbepx+/bFb4D5+yyPh0paB6fl0fxnR779uDAt8R
	 ar/lFz7ZzAZCo6SmIxohaq7TaiRk8HFbSTKEXuvTkpKM44K7wssVHFDfyCBm6hmfqw0ck
	 Z7Nwmb8NJ8D4WzwNaM1jr5a4ZIduIuxZJUABD1QsMt8hqrQ9CXWdkHh7ENfD3/IApaPPU
	 TPGSjt/kmjdOHp1akGo2U25WJeBt0i4qXIetnogr2oTcICRs03+sqw1yPm89fCTiaZEDi
	 Kv4luCC/iMLpLnOIYINgYKm56z8dBFq41KC6wgWmbE4io+IdWkpwH8ZPsrebHpvMe+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516616;
	h=Received:Received:Received:X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:
	 Feedback-ID:Received:X-Mailer:MIME-Version:Date:From:To:Cc:Message-Id:
	 In-Reply-To:References:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=FPjAFqoQ3uCxhlJR+neifQbJwXA/vEfAzYz3BKKcjZY=;
	b=XUXLJ//Eh6sLJue6ZDGU3cYpHs8+efvZdYP0TEP9ftps9DxOZPkyVlUkG4YPs8p6Qdcs
	 ePmqBqTtWTUrKSbw8cv7YaNxErxusREcCL7tFm3QkbSGkKk2RImYUTuTom+bscpCx3zFk
	 0UTPFxV/zmZp/Hs1pqLs+EDJXnDGkg9XDw2wvbUt5f+Srn0gybJSEJmhkSaxpVJHRutB3
	 NSdBCHa2ViXpIwPwOyauQCZeSZvA8LUANTYirEl0sx0PCGKtMhIwZtmodEvLIHLCzFSSw
	 aCYVNORyPgLwk5R154lc21Nu/OXCjG7qiqxbiZRgkBBuCV0538xufLCa1h6Po43ulhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51F606B50F
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 17:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC51F000CC;
	Tue, 20 Oct 2026 17:16:55 +0000 (UTC)
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfauth.stl.internal (Postfix) with ESMTP id DCDA9780043;
	Tue, 20 Oct 2026 13:16:24 -0400 (EDT)
Received: from stl-imap-11 ([10.204.2.102])
  by stl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 13:16:24 -0400
X-ME-Sender: <xms:6KHXaknjuljWSJ_gLoTQgYf4xJWg4wNsu4fklN3FpLLgaVvabsfADg>
    <xme:6KHXauovoWDDRjZBCpZ0xEraTP2R4PyIicQXMd88LxekLG6Miu8rvmM-vPsnST9PK
    4VIMUx_O8Egp_ftDXFFX2yoqiempAWZnUWpIS_JYpPMs8rpu0TkTpBB>
X-ME-Proxy-Cause: dmFkZTGotKvzjS3n3TRZ0v50m6h3cI6EI0s9z7DT82iBKKE6Q15vLsJzsPvrUeyFhM+Osf
    gQCGSN/0gacl8Z4ETxw3tPKML9dTO4lVuF/F1klvXVv8yGO3r/A3uaav3XzkLOIXYLTMZz
    FFsqF7wAcYpunmwtjqbgXO0l1J4vjGUPW6oukba4cH286gSRIKuXCdz5R98K1OWeaG2m+k
    MQ5HP8jlxADzy9DwGV3VVFP595AkljBUghI3tobW5bE+wnH3T+cxf5UYbM2ZjuXpOuS5bo
    V+Qg4/JbI5PY79uavQTDd/cYy4kHuix8Glymj2Al+JPFRjDOnkjOLZwG9ETDzscip1bYOY
    boWxRTt+GnnWCgRyKBro300WrNS4yllkq7ZKa6W6h0Krfze99kR9JzADcwZ4HiFzM9MvXk
    gdlIsp10OKuK7h0B4l6Lsd6D5IdrwYy2teubhp4ZYsB8ke9VRntGr6uyrRA/O3fA2iV3FW
    Yq1kfPcYST2wK+XfBgxH3qpcHK/xlCgl6APcu1M8SWveBuoA1Gy89zuQ90MiSfiw0mIBsU
    X5dQ1zUbmUCRuvYprsMEfe4l+dnZyJ824lFTaa8BcDRRR3kz4tEviUxn6mS1SPl5tHjq+j
    w9XhYuXSMm3szsIbxNLwfxDLxoUALkZOiu5JN79H+ofWPCDS7pOX/VRTVbMQ
X-ME-Proxy: <xmx:6KHXattWU7Z3Sqk_rm8d5sLXgOXTtvCqoV1ea75btZEI9bRYUnuK3w>
    <xmx:6KHXanY7oblVJYgKYCBiV8pQa6UjratFWQJW9r93TNIGhewYvMYcNA>
    <xmx:6KHXahFbh-gKBMmv64oWRzKlg9qBMbTS7C8NzsEgJv02Uks0cT-lQg>
    <xmx:6KHXairWoPyUbXedVnIjMBlVV5o4AyWXqIw72jOkHezuCsVdipRqAQ>
    <xmx:6KHXakyOkqXNqfvmKNMo2342wwN0RdRYFen0Myp055u5RKEa_tIF-tXz>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 7780619C0067; Tue, 20 Oct 2026 13:16:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 20:16:04 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Logan Gunthorpe" <logang@deltatee.com>,
 "Popov, Pavel E" <pavel.e.popov@intel.com>,
 "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Jim Chow" <jim.chow@broadcom.com>, "Radu Rugina" <radu.rugina@broadcom.com>,
 "Alexey Makhalov" <alexey.makhalov@broadcom.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Michael Kelley" <mhklinux@outlook.com>,
 "Nathan Ciobanu" <nathan.d.ciobanu@linux.intel.com>,
 "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <2db83aed-1137-49a2-99a6-1369f163c273@app.fastmail.com>
In-Reply-To: <db26b21b-8416-4b11-aed8-3829ed5a6cfa@deltatee.com>
References: <20261020161447.GN64621@unreal>
 <20261020163758.GA2342476@bhelgaas>
 <LV2PR11MB6070444E927B9AA891B8180FB2672@LV2PR11MB6070.namprd11.prod.outlook.com>
 <db26b21b-8416-4b11-aed8-3829ed5a6cfa@deltatee.com>
Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Oct 20, 2026, at 19:54, Logan Gunthorpe wrote:
> On 2026-10-20 10:47, Popov, Pavel E wrote:
>> If preferred, we could use for cpu_supports_p2pdma() the pattern Logan
>> suggested for hypervisor_supports_p2pdma() in v1: the whole function
>> under #ifdef CONFIG_X86 with a stub returning false for !CONFIG_X86.
>> The Intel CPU list then moves into the same #ifdef block, which saves
>> one #ifdef, at the cost of also touching the existing AMD part.
>
> I personally would prefer cleaning up the #ifdef style but that's an
> issue that's already in the code. I don't feel the need to make it
> conditional on my Reviewed-by. If you are able to clean that up, I would
> appreciate it.

Sooner or later that cleanup will be done, and I don't see any reason to delay it while we are touching that code anyway.

Thanks 

>
> Thanks,
>
> Logan
