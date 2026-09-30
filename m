Received: from mail-oa2-f41.google.com (mail-oa2-f41.google.com [74.125.231.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130F4F68DF
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781163; cv=none; b=tdsf24CG/CTEKzB7JIj3hNu7Uu13O3nA4L8Vhjr4AXFk/0P0xyuwabMsm+yKqJV9rh06GA02v7CrvMl8mtG2fgx7LPAuIbivo+IvYUaY4GPz7PACuSmA7L+cN/qKkZuaPE3TfMuY3279cKauJymriDTlmVhFixvu3jIKgnISUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781163; c=relaxed/simple;
	bh=N5TwGmCOg73FQhkQUlqK26vGWZ+6twK0jOc1jidbG9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se5A/DY+TNusn38aZU+Srm0i8oupD7AJvmtcQ5ULQkS3MW0s5Trq5Wib7tjVPPBUlR1HVJT3GYDW+j41Xv7O7GdrL45KZqxOKX5xMLrpwSY/CPk1LOr5/djIhCxLeoUAug+YjOAlXW4AJRWUFTMejYs/YumR0KkH6Wp7Iy38mC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F2LynHut; arc=none smtp.client-ip=74.125.231.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F2LynHut"
Received: by mail-oa2-f41.google.com with SMTP id 586e51a60fabf-47bc923fe6aso3478965fac.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790781152; x=1791385952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i3zztcZwHv33xTSBhcuuRwUuO/mC2YE/oPR+7vCHXWU=;
        b=F2LynHutv0ZOmuF8vmFQU0cyqiI4GB5kyNhWNIcFmTm03ZYDlIdoeMvOS1ol6pHe7P
         1opniFMp9w/1hoNxwBw1abApRh1Po/j0x2ZuaQZgt0r7WvI/GTEHkvv7KKThQRNgUeDk
         U3vhG4nOcBSBbCwSBzxPAF2/N9kbmWUuQeOCbbHXQ+GZ3OEDXh8iCi7m7OhysGURcFuR
         MYdYJN3ZhgKPd9PQq1QsBlgi+KBVppXhOjswSN+K42z+R3efFI3SH3JDdd9Kub164vap
         FKr2jNuW6GBhqs4aVFIb+0YT7DujIACVvy1vKyp41BAFenyWoJ63gl+3RGCO5hghcRCU
         QQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781152; x=1791385952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i3zztcZwHv33xTSBhcuuRwUuO/mC2YE/oPR+7vCHXWU=;
        b=1nryeIEqI903XrEIIEA65vZyEBsAFIBnvb24lxmGB6FS6U4zGcmZ+IADsGvgDAjUXF
         YufSXY+IbSr6YgZunqaLKK+xR/4nYN9NVSMFp1USLLvh6viy/p8sKEPdMQ+puGgI0Ky9
         MvAPA7nBAiyih6jNnYBX+zlXmrL4Uu7iYirdCu00lefNd1iRLoPHX32a2FfyO/DbbQdC
         vd87u2gxprZYUvB60iWON3bzeZkbxYj64zUmhWZl2HBibx5OgyaZ+/JZxTeQLl9YL77T
         zngNHPbScZz4hhnjWhnDjHKbcseEnsRWXqEZqbK14Kq/J12kcW1yuSJnVF4qSkoj9zxF
         aLsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcWlckDl7OnR79ppLSJrFTjdZNu7WA0N3t8kGT9gmwUfZlY8ia7u39NMCW7kbrueJpTkHC+WlpS0Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lnTwG1K+zD13eP0Iz28gnddDPcOEsF/3RTp11HmZVxJjcx40cY
	7kcRxjnA8KEwlxXoRzoP05t4Zz2OGSAHhsadKTH5U3VurAUkFEjzgFRTRh02g2AHS64=
X-Gm-Gg: AYBFou082mt+o55JFXBkHfw2d8clhTPMBR28Cp+fO9b7Ymf1zm/9F5zcVG4iVJbEouR
	yDwkmtf14maQH9RFfAAQmJgsh/Rsg7Dqa3Oz08dHrahF60dua5RNAE9RXqxoLQIFRJOxhEFvTIZ
	7ikCypoiARXzllCrQe9UtSFQukOgFz3HOwTMgL0Fjn6Qejk1euw3yhLq77iJRcT4G6hJFqN8OEm
	+yNLNl3l6VIu1WNYrqPCKpKytAVEacunSRjowNcDoKAAXaCMKEYKFzrkEQp+cDuQI/z0U7c2iz+
	ebougdwzq2PrUsSHdLZC2TvE2z4rBobF8Ts6D25MPs4SA5tLdzZEi3Tdwx5p57Ox1l+RjoMLf25
	7F8mUKrh70W85+N4rzbwXEatDrZXw64ThIuRc7RS/xWbw7Y9mHrEjfxfG0fqA8J3fFCUS67Y0TO
	QiZYdn9B/zXI0SEjsUlRH3A3M5uE5LMBdfFMIAtR6mRbUJ
X-Received: by 2002:a05:6808:23cd:b0:4d6:90d3:e187 with SMTP id 5614622812f47-4f1b9a4dd1fmr1463609b6e.48.1790781151901;
        Wed, 30 Sep 2026 08:12:31 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f1b61be7d8sm1076055b6e.17.2026.09.30.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:12:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBvyv-0000000BwZW-3H3V;
	Wed, 30 Sep 2026 12:12:29 -0300
Date: Wed, 30 Sep 2026 12:12:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, alex@shazbot.org, jjohnson@kernel.org,
	johannes@sipsolutions.net, mani@kernel.org, yishaih@nvidia.com,
	skolothumtho@nvidia.com, kevin.tian@intel.com,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] vfio/pci: Add qcom-vfio-pci variant driver
Message-ID: <20260930151229.GR163130@ziepe.ca>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20260930140833.576941-4-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930140833.576941-4-jtornosm@redhat.com>

On Wed, Sep 30, 2026 at 04:08:29PM +0200, Jose Ignacio Tornos Martinez wrote:
> Add VFIO variant driver for Qualcomm PCIe devices that require
> MSI address passthrough for VM operation.
> 
> Qualcomm ath11k and ath12k WiFi devices have embedded interrupt
> controllers that require physical host MSI addresses programmed to
> device registers. In VMs, the driver only sees virtualized guest
> addresses, causing firmware initialization to fail.
> 
> This variant driver:
> 1. Caches physical host MSI values after allocation
> 2. Writes them to extended config space with magic signature "QMSI"
> 3. VM drivers discover and use these values automatically

You should probably explain a little be more here

1) Linux VM driver fills up the normal MSI-X table
2) HW has some non-MSI-X table registers
3) Linux VM driver pokes into the interrupt layer and extracts
   one of the MSX-X table entries addr/data pair
4) Linux VM driver now programs that copied addr/data pair into #2

This is, of course, all wrong. These days it should be using one of
our mechanisms to allow devices to have their own private MSI
registers.

I forget if this is the right way for PCI, but the driver can call

  platform_device_msi_init_and_alloc_irqs()

And directly program the MSI registers with their own special
interrupts vectors, no copying from MSI-X.

If the driver is fixed to work like this, as it should be, then it
fully breaks the scheme you propose here. That's not good.

The problem here is not really a qcom problem, and treating it as a
qcom quirk is why it keeps being stuck, IMHO.

The real issue is that this device MSI scheme does not work in VMs at
all. It does not work because the VM IRQ design requires the VM to
trap and modify all the MSI addr/data pairs at the register write.

The technically clean solution is to redo the VMMs so they don't
require that, ie use interrupt remapping so the VM's view of the
addr/data pair matches physical. That's super hard and will probably
never happen.

But! Now that we have these device MSI domains I wonder if there is
some half option to provide a hypercall so the device MSI domains can
call out to the hypervisor to get the true physical addr/data pair to
program?

This is fundamentally an irq layer issue in Linux, not a qcom one.

Jason
