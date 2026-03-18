Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89672C15A5
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871613; cv=none; b=DTiSgbWiPrDY8B52/MZ//AwloppJpGkpJvxVfsJH8j6K+jJgacJMEwl6vDH2xgbYzKrtZxRKy6Mg8nt27IPLS8za/d2OQKmIribNYmZm/hMSPW8CToVInlH+VzLO35pJca+jyJp1I1a/5BZETkaeqNdtQ+ykRBMZFyfha6hp1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871613; c=relaxed/simple;
	bh=Mm5cgq431AMp+29aAA5yYiOJktECVQ9HyfYhNIrC+D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWkoS0IX7zupC/oT685RUNYq2zQEvrETZv87OpI26L7yw+/9CgTcn+fkzmJDlc8GKPw8T9OrvZFOF/gR54CX0E/7pUZIeqH8f73X+ZxUOBvGVAK7hXIFZktoQD1JKumUfTVS49xbZ3OU4PKACwW+HZ2cAEMYMA6naieUUJ2sqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvWfsxO7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvWfsxO7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so29805ad.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773871612; x=1774476412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm5cgq431AMp+29aAA5yYiOJktECVQ9HyfYhNIrC+D4=;
        b=mvWfsxO7SV5o+7Rxjz3xOeyc1mbt3hmn6qSc6JxKQH9DjHkeSb4ef0LKXYaRqdJN37
         SmBijdyuCcQ8th+vnt74qHjKgEKlsPXgXwsg6F5taZ2mISm6ncMFo7HuPQLGZIQRW6MJ
         LIqQAA/Zb2WBpT9EOVoS4RXjzyAc9Hram3ZqxpgT9Jl7crc9z6LzAO+ZiqXz4SyiZDKf
         LuvwO2u8T6O2QrQYZA5iGmlBaUNVpilJbAPhj5EIDElBn1WddTS++Jv24tsFw3ZiggBF
         5MmNwP4zTfpO67SyatbErYLY2J2VapMnjjNBFsszGL9td03+Igtyysp1u2rqUVddRggb
         4S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871612; x=1774476412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm5cgq431AMp+29aAA5yYiOJktECVQ9HyfYhNIrC+D4=;
        b=U8v6W2jfy13wRl+YyA4SPHLvMVYijQ+PvRDLYxSmEZ0FB7+bYHgNT4QNcRYsv/kx3n
         TDSh8tlEBIIogdkJzGwS2QJ51gfq5pgg3sixzFsGN35NEfeq7h0Wse4pSxPg3LnGrI7Y
         8y5RKahMJ7lwb05PRqIHc/klZkMpRVxJGfFNT0gmOOL1msTgJUyeHp2asf3Ig5TRjaUj
         sjES3K0XkOeTqiszQyHeoaTLl79bzjl/yzPLp6zCdGIHFefNEDZu/rCGxi89f/nFSwLx
         mxYU0PIn5VCNS4FDiSsE8tN6Tt/K9RawzDnPglwC8ACYMsPKOdLisizDSRxhgnaT6y6U
         pd8g==
X-Forwarded-Encrypted: i=1; AJvYcCVT2uhvG8bjIaB7O1cQ2M4syUw2gcK5JHhyqi1begT3agspHRgs9RyDEKE7tDT/m69DIQ6JFZCLh5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPOC3H4GHNHTz/h5Y5unYOfiL89bjqJl/2KuQ1Kq8bHt6NiuN
	D2c7nY/PiOYtOq12WO+Ijey5XCxozhsLVy3fSimaLXTIhsZDcxOPCZA5eynzsGVe+Q==
X-Gm-Gg: ATEYQzzQfiHCpLFo5EKAWI2N1eUIHGFdGrPEIIMRElZJa8h8qcZJEySJUDABJOteRbv
	ogc9y54qrgy3u3otTYf7BtvYE7xwVfq5UaalWNcSRN4tMNYGBw1UsO5KfJnDUTJWIYGDC52C1wD
	D54wnpCqbaZPeg9A0SQXPY79AOcFAZFJHtyAmsbUjkpAQ/qnyyrPKopmP24uuR4l9tB0u3r+Z14
	637ZJ8o2tJNiQBdu3UUnEhNNeQmBxN/c7dMSWUnS57TvQsSYRRwm/tyEBAnAmWcgX2MwRr2Q2sq
	PGvquG6W4Ttxc01OvSga6uLGUE57h9kWs0dGy9Z9QJjRXHge5Pls2R0s76lNHF5hErJTxlq/bGX
	aLDzf9WwDi25H+7inh909+jAWLzGAPwIBW0YAuIZmuayFAOfHuKMgFFrPhe+IKomM9USmdzdW7g
	gwKoyS9X0zbfKVNOU+6O2OiP+OIBqA/VZ7urhDjR3j9LkfxtyqHcHQh4LoeJ3xUQ==
X-Received: by 2002:a17:902:f54b:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b077ca07c1mr1353525ad.2.1773871611494;
        Wed, 18 Mar 2026 15:06:51 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e44a42esm37397735ad.33.2026.03.18.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:06:50 -0700 (PDT)
Date: Wed, 18 Mar 2026 22:06:48 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"jgg@nvidia.com" <jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, 
	"lenb@kernel.org" <lenb@kernel.org>, "praan@google.com" <praan@google.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <absaKimeI_TXXxuu@google.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abr8aS/MDU9aeKu9@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abr8aS/MDU9aeKu9@Asurada-Nvidia>

Hi Nicolin,

On Wed, Mar 18, 2026 at 12:26:33PM -0700, Nicolin Chen wrote:
>On Wed, Mar 18, 2026 at 07:36:20AM +0000, Tian, Kevin wrote:
>> > From: Nicolin Chen <nicolinc@nvidia.com>
>> > Sent: Wednesday, March 18, 2026 3:16 AM
>> >
>> > An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
>> > aware of the timeout via a GERROR interrupt, the driver thread issuing the
>> > commands lacks a direct mechanism to verify whether its specific batch was
>> > the cause or not, as polling the CMD_SYNC status doesn't natively return a
>> > failure code, making it very difficult to coordinate per-device recovery.
>> >
>> > Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
>> > gap. When the ISR detects an ATC timeout, set the bit corresponding to the
>> > physical CMDQ index of the faulting CMD_SYNC command.
>> >
>>
>> It's nice to see the ability of allowing sw to identify the faulting sync command
>> upon an ATC timeout! On VT-d it's not feasible when multiple wait descriptors
>> (similar to CMD_SYNC) are in-fly... :/
>
>Actually SMMU doesn't know which device is faulting when CMD_SYNC

VT-d is able to find out the SID of the device for which the device TLB
invalidation timed-out occured by using the SID reported in the
"Invalidation Queue Error Record Register" (VT-d Specs 11.4.9.9).
>follows ATC_INV commands for multiple devices. The commit message
>in PATCH-7 describes this in the end. So Jason suggested to retry
>those ATC_INV commands by bisecting them per-device, which allows
>us to pinpoint which device.

But for a software timeout, something like this would be needed.
>
>Could VT-d do the same?
>
>Nicolin
>

Thanks,
Sami
