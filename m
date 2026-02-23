Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763A37C0F6
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890229; cv=none; b=Y/nGacsqn8hsv601y2vOB20jB5yle9IUUnz296MYe/zyb06CfMafd+WsUWEuJ73KVO0c1m98kIS0x+VO/wnFVLhwGEl6EcH5S7fH6/i5HO/5oR/UVsEISM7fNDeamL+ZldtcBsOtUn+mHx16Sd4yVntJIzj8kfmGmRV1uk3RZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890229; c=relaxed/simple;
	bh=ixq3EXVD+9YovL/Dhlm10KQAl6fwXAJ2uZkBL4dtJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsJiaxvQ9J3WSeCghTygyDUTP9jIOJMkCTVvRiuNLYrEpo/87DZnVOf/1mDgxrHuP2yAxQJy/HP/DcyUiV4GvqI8C+FC0pgDyKWf92Y5GppzgZXB5njBQWnPQ7IVhRmmZJnjLqlGg2qeKl8QHBNpLiAGHE3eJ8a5MBNKhCA3wgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2veE+8f4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2veE+8f4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aad8123335so12925ad.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771890227; x=1772495027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Nz0fZa7S09a21wJlX7cSiDYFAmJR+w6WbxCWC6v114=;
        b=2veE+8f42mkrsLFlgFazW1/bxr9ic3+E09dCe7+j7j70c452Zazxr1PbNf25jEiCwy
         OyH/NxseCRKAFH/ncPPcQKzZybdZ0k17OpIo0BG9INQH4uGMdLnN7vKu70iuv7H3Op2Y
         aXvbKJPjmvW2qngVHqa9GP8Nnha10zD5bbIo9Q2OzN26D5MvMrZMurbPqkAwXRzn6v4Y
         OEvFY7AbpsH1jy5G5OGShB+1qvk/XNiVwN23vP44YtyUGVlInt8mvU3UXa9PeD1ptimA
         IycEk/fUgP35GQCUJNk/mqF4GKjk9Iiw6mteOoh0JC4MJ52P/jrkFz/Lfl3wmtAFl6h5
         6JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771890227; x=1772495027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nz0fZa7S09a21wJlX7cSiDYFAmJR+w6WbxCWC6v114=;
        b=oIwDqqLUJHgdWxMBRfIyqo0meUauuoFI9deSRkx2oKe6E1zTZJPaRtrUI2dDM9X7ra
         EShFr+khOmGsMDHM4ZtnmX4D33oGgaEw0QehSXww4wpnLGGmMPl3qm8siZ4Pa5F9C//f
         dl9nHDn+PdzcR8vo88v5xQ7QTj+XpeQpueekDGvzPwlve11RwjuG77Iq+SJwag94mBvV
         iI1hvKX9O3DyOcYKD2QRy4swHXVCFNfIsd0OS8Ce91Yu0cm/OtCYmnisYRGMWEDJ+Rzn
         VvRBv3B8D3sVO/AZVbtZzQjYOIB7vEDOzdpLd+mM0Az1eTYayj8L8DZbKXAn+JaV3FYK
         qPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb6yQNpvfeEt2NBZWSTDDsVXKowZnPkPYfzAt2gCVL5UzMz5laFR2VlQ9gDDdoJ/L3tBYipsklJ5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GFM2QbyAKfVmo3Dyl0Smw3iDGBc5Yi4+BxQrjmZTy7jsReRm
	OCkFdUN0Adu1rRb3XmwmBcs0jsHQBgsjLy8f5SvFO7CG7AM1USZiPd3b4F16alkfzQ==
X-Gm-Gg: ATEYQzyGmTMM5PYakltyM/WPO3VaQxivs1D8TWZdZz70Dz/mwHhbyF11mr52Te2kQ9q
	m8W58Y7zaHzZU4f+xgM1bi6u2qzDaQzNoMrJct1WwuxcSYankiAMZC2gxBjHjCY+BNlm1pueRSt
	xH7H3oz2xE24XZfAdOf+mrWhzPInbCFgCuGgfdYLWLuYkiC71PFfo34uubUyhOa4E+XjKk8t6S7
	EOLxkqrXFUnh2YBAXZl0qqNLnuBdKXEg4xB6CVOA57vipSrsnj2/s214HuTe7LgH0E9YIFm/uRP
	fy559FtlmB1A0yG/WGio+dSaZoyKiz66oc7aIpVCRCVpZpLDbCSobML09xrfbC6ebWuVkWDIgtl
	+/raCZDBsSnc7SAU32DjHdT3Hq5X2yEozbXNdN/5o4Wub2GZLJGjANrX/t+KZ9GiJuyFRHoqAhT
	ZOZjwN8KZZZrRvIl6b3DLg/NrVxBijIVwFNtSlSxSgJ867Szw4Y9oODBzYEC+1/w==
X-Received: by 2002:a17:903:41c3:b0:271:9873:80d9 with SMTP id d9443c01a7336-2ada3483c30mr271955ad.7.1771890226940;
        Mon, 23 Feb 2026 15:43:46 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e1c0sm90833575ad.45.2026.02.23.15.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 15:43:46 -0800 (PST)
Date: Mon, 23 Feb 2026 23:43:42 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <574e4wq43zm5tyfvvtjfvzqlhoyijcgvvk7gptghrx3ofq5ck2@l2q7xbmtibbq>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-3-dmatlack@google.com>
 <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
 <CALzav=eXY=ZBshmpi9axt+_0SxaAm0Xbo7w==nCWJwKK3xcThw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eXY=ZBshmpi9axt+_0SxaAm0Xbo7w==nCWJwKK3xcThw@mail.gmail.com>

On Mon, Feb 23, 2026 at 03:08:19PM -0800, David Matlack wrote:
>On Mon, Feb 23, 2026 at 2:04 PM Samiullah Khawaja <skhawaja@google.com> wrote:
>> On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
>
>> >Drivers can notify the PCI subsystem whenever a device is preserved and
>> >unpreserved with the following APIs:
>> >
>> >  pci_liveupdate_outgoing_preserve(pci_dev)
>> >  pci_liveupdate_outgoing_unpreserve(pci_dev)
>>
>> nit: Preserve and Unpreserve can only be done from outgoing kernel, maybe
>> remove the "outgoing" from the function name.
>
>That's reasonable, I can make that change in v3.

I should have added it earlier, but the same applies to the
pci_liveupdate_incoming_finish() as it can only be done with incoming
kernel. Maybe we can remove incoming from it also for consistency?
>
>> >+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
>> >+{
>> >+      struct pci_dev *dev = NULL;
>> >+      int max_nr_devices = 0;
>> >+      struct pci_ser *ser;
>> >+      unsigned long size;
>> >+
>> >+      for_each_pci_dev(dev)
>> >+              max_nr_devices++;
>>
>> This will not work for SRIOV as new devices will be registered when
>> sriov is enabled and the max will increase. As we are not handling VFs
>> with this patch series, this can be fine?
>
>That's right. Since this series does not support VFs
>(pci_liveupdate_outgoing_preserve(VF) will return -EINVAL), I dropped
>the logic from v1 that included the maximum possible number of VFs in
>max_nr_devices.
>
>Once we add support for preserving VFs, we can update this logic.
>
>Another way that pci_liveupdate_outgoing_preserve() could fail due to
>running out of room is if hot-plugged devices are preserved. But I
>don't think that's an important problem to solve right now.
