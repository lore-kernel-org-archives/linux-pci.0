Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958273;
	b=PNUdnNnqUF60mF89JzzNux4EEWQjo99FiMWO+dgT/BE8SazdYGr8PB+zE6brZQpqdCCp
	 OoN5x3P0vOiy4X75I1utPt0qqU55aehzObw9cFo4CJltBr/tbKqk53L7ndeK6B8et+2EZ
	 ENTyXxzvvw/X1zxXbeApEqM9fS8gwXEoOvnUZ92U437MI1SsHkQoK0uY+b8VRQ7Fzo7Ks
	 N1rB3zsvAQacr/5KWvIZ7/ENiwsCXUYzYub0s2TvvWVBhuYUUC9GiKVO8wraEz0Bkr0JM
	 DCoqpLI+C0pg+yB4o92fZNCIlcwBohJmjshiD1COT85ZfMIm3kTix/Gye/Dld4zPtew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U+gaTE2rxn1GavMY3VnMCM5lJuO+puyH/nRlKYyd314=;
	b=ASaMuzcQk1vDermGBOEnfru/SB+O9+dgHMSoROEXxCyOA6U1rCVS4Id8kmij9O3wD32x
	 iaGO7WmTtVCB/EKAyyoV6j7j8IAEybeuZtBAwyLwakmx4fjRZckyNWArftGrx3I9F3OlP
	 9qr7hXri5gCZVp3SRt0d4us1Pl5dOEbS29eDSUavlzHQ6NX/I7s0lFpORm8zsuU26kMB9
	 M+Pv9wOW/OKp4EQ7KY0F9qUXHLdzHN3Yi9c0gHbY/mxtdnS6s57cYRaS/koRHtSJDnc7S
	 bfXtIgne+5+mK03q9amwRElw+8ByBzFTSoXtis/BF91uaa+l6wH4MV4kq6FJdCVDwVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=caF3b9P+;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53848606A32F
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 23:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53848606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=caF3b9P+
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ee254f6eefso28695ad.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794958273; x=1795563073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+gaTE2rxn1GavMY3VnMCM5lJuO+puyH/nRlKYyd314=;
        b=caF3b9P+NR+k+dVrQYKdh17waZ1fQkOvFK0irAfpXAI807UYUrz7R/ISB/NUXoW16m
         9S3Qvfy/5rcY4x+PHjf55xliTNxH8vJY+V3tWWZTi20JUI2wbYV41lJtE4WMiL1CuMXg
         o0EIb6BdrXKx3tWqCpRqfYLMkqa92HdtVZqqIO/jwKspOotbWDdVQ+PDo76+C793egT0
         QtZ2I/yEixxmFiwLrmgG9qVQemeeyFZT5bZdJBh2eFGZ6jpTPhxQ5x1yBDGvj5skyy0F
         S3wlk8yLXOxGb5j81dAWfQbXV8r2y7wjgMgBZn8xbPdqlFigVmliOkAd5Pf3PLUN6cuq
         72Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958273; x=1795563073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+gaTE2rxn1GavMY3VnMCM5lJuO+puyH/nRlKYyd314=;
        b=Cy/oTSSHcsse2jnXyRwISopv7YPkMKTWJCKPzW9oCgBhTHHIFoTj6+2/q3tApuYvIL
         TMrP6ptvd1eTg9NtnLKFGAUP3O3obTx/OM9TXFZ3NHEZikzinQ1NtZ6LtOcJD9t7a8TY
         Voz8jXY6FGCvB/cQuTW8DB+7Od4uD77N7+dxF5vIBf28oDd521b/yXzKxz6pfmlfJmAo
         tAIfO/436VXcNSDjap/3YlLRocv9goLC5VEFnuO1FjA9/KKPp0VPlpG2QVEZYl2Y+WWF
         tZNv3ePEQsQIOUHk2gdpL/0NU4sM5M4YAUbjaGcYEW1DUiBmA6c0bwjBMuID2cIe3E3w
         4GDw==
X-Forwarded-Encrypted: i=1; AL+hErHtgscYTJsz/AwzL93E5DmXqlDTZLpH8jKfRpiy3RkVWygmcfRCi61vnVurfiMt0hSdDeE8IFb5rU4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FgzusbNIKvFR4NWd9HjTZcI2ApLr/l7e64G4w6eZIEnwDZMud
	lTw8POOw6lo23LYIUwKTXMdKUliOox+YMRTRzOWrxf74P3QWBGKYRg7h5i1fvp3iag==
X-Gm-Gg: AZFdTZdSJAojk8SJVZGkZuD59f1FsPpHRhrva1iZpcrYVVscJO2p4Hm+lcA3ikh87lZ
	nI4C7nsbOhq9My9VJKmGuDsX9DL6Xevan/fCi8joqMfPrTAuQFkJhYSLf2NqRUJS8I7ze6RpNkB
	+YanTYcKLttuSsSoftvvYT05vN5e36aXzxJlELj2nm7g+ziKyuTICFsjrb4TYCzCt2Py9G91YlZ
	bRYiN+Ur50Zl0kL3h5ckS+q2L6VpvcKvPWWgjWlLZ13vnCPUmMprlgWdgzLH7C2WQQGv1Kujxoz
	ohbt0t/HG+r98g7L8XbAQqIHyEc82PhNFEKQvCi+YfsM4WW+tEjlfOtzxxkJb82iHKekNTojGXY
	6Ox+rypLEscIeUoVz3rDOXmQxfa+Ve6/mHcGusZC8TbYa7nSHQrY9BnQh9IOEBZoUhC7dVrxQfQ
	fn3Vhpavqfh7YKwpaVhiySoC41mnCqSW2NLpjUyLOs9vLWScai6nivla9AJiQjAEhnH21MXgFtc
	RACNP4JdSAzEbMOe4Hr+IyD+jKH2Y38P7ySygC5pR5wSOklIDGqE4lFFqrDkOZm2DLT3S1RD9mh
	fo+NyiWGF8eYzyXbXMqHUe1MgZt6tzulyYAjl867DRGRF3YUjO3Q3TIbwDRxhYuhD2JK+6plE+a
	zd3Gid6FArjsb/EyijJVXDg==
X-Received: by 2002:a17:903:2cf:b0:2ef:d87f:8a20 with SMTP id d9443c01a7336-2eff9910e43mr1188255ad.12.1794958271877;
        Tue, 17 Nov 2026 15:31:11 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff5ed0998sm3827275ad.4.2026.11.17.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:31:10 -0800 (PST)
Date: Tue, 17 Nov 2026 23:31:08 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>, 
	kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
Message-ID: <avzfBjBZiOnJUH4W@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <an0BOyexLcOjFJw9@google.com>
 <20261117225559.GB2250529.vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261117225559.GB2250529.vipinsh@google.com>

On Tue, Nov 17, 2026 at 03:02:00PM -0800, Vipin Sharma wrote:
>On Thu, Aug 13, 2026 at 10:30:45PM +0000, Samiullah Khawaja wrote:
>> On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
>> > It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
>> > while SR-IOV is enabled.  This can not only result in an uncoordinated
>> > disruption of the use of the associated VFs, but the ongoing use of and
>> > access to the VF has the potential to result in machine checks.
>> >
>> > This series proposes that this gap is largely an oversight of
>> > pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
>> > violates the scope boundary of the pci_reset_function() API.
>>
>> Hi Alex,
>>
>> Thanks for sending out the RFC to fix this issue. I cherry-picked it
>> into my environment to verify that whether it fixes the issue I was
>> experiencing and it does fix it. I will continue to do more testing, but
>> when you send this as a formal v1, you can add:
>>
>> Tested-by: Samiullah Khawaja <skhawaja@google.com>
>> Reported-by: Samiullah Khawaja <skhawaja@google.com>
>>
>
>Hi Alex,
>
>Is this series still on your radar for formal v1?
>
>If this is the direction we are going in I can use it for liveupdate work
>  https://lore.kernel.org/all/auzftbPFO_6XBYVw%40google.com/
>
>Thanks
>Vipin

Hi Vipin,

Alex asked me whether I or someone on our team could pick up this
series. Pranjal is working on it and will send out a new version. There
is some extra work needed on the IOMMU side to make sure that the device
is moved to a blocking domain when the reset is skipped.

But I think the patch you need is fairly independent and can be sent out
separately from this series:
https://lore.kernel.org/kvm/20260812045325.2733631-6-alex.williamson@nvidia.com/

Thanks,
Sami
