Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3529346F
	for <linux-pci@vger.kernel.org>; Sat,  4 Jul 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783176318; cv=pass; b=Ha7Bxp7ZyXWjTIW8XiwYEMisBJQJ9jH/TzUO3ulUPEugzPa+NcHr0frTBlkssC0O/zRiLAQpx/QeHBzWrW6nhdlo4BtREsd8wErdBB0I24h9JKy0RYdOVhR6YWlcqN9jXErQSPC1JqP5C1+cTqxjar0b5wq6MaNI+vrEPyBE79o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783176318; c=relaxed/simple;
	bh=XpQJwh2GgNhD6EAOhQ4I53c3yuO4+5Tzr8NzYHPiJFM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rw1kqE6uUT10KMIGL2i8dwbdXDJOBBTu6SxXk9gELv4ij8ecw9cXZLOf4Eh2eMGNSuH7H2ORAqIKzrLC6UbESrA4Y8wZ85LSSYBDTYZZqD9QszsH/G/KBKqwCj+XORR/AQEn7/HlcYG6eeKRDpyNh3gxZSs7OP3OCot1dyd8lEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mj3X2Ytv; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj3X2Ytv"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c96cb024ee0so1031895a12.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Jul 2026 07:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783176317; cv=none;
        d=google.com; s=arc-20260327;
        b=LJ1WBH6nRrMzPpYsIUSQgerAHuqzFJyJ2eR9kKEQRgQrjV2nG4N3XR4D5lMz82e9SS
         f9BTl1J1cpDgWcUzhKGtWv3mN3WGfD67G9mlAxuBQSr9Lo0G+LG8QTcSNJwJr3wk3Nkg
         64D6tY/y9QKwMkoxZpQS1XlzOh7kkftMKtrL5uWFFTvkno2RtjMgwkMZlUoeCystJ8On
         gF6teQTpJhLjzib82pkV7M7BRLLhEVx2qbmSNM/2AEbH8tejXbSZWV7JixQHfXHwJ0rW
         fWbCFMh72s2EAOieC7izFaRFIWRdq2IUNSrDnHZ56uVIY+1lnzmv2V07TXvMqXnxpGl3
         HWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=L9xOVRuKFfEvpugkoigwFk6Gb+xTAo+YrZVd7V9k8iM=;
        fh=uDpZu3WE6KAM6SyY53FMr6daP66juPjjWrSMBznIrqU=;
        b=oJG3XkYO6De7wHRvtS+WtzhUydID3gyi6DxkzInHG91iIfGaA6O7LSA+FW/ilIWdOZ
         QgIlxL/4PFMQDzi9W34Y/HA8meCnHBFVCK2IW4B/H3W+VGyNFCyOWXx4iyHlGZ7qXRyb
         aBGW+aJdP1NjwJLVOMXbEMPkV0z9mvr/dJkedWzThTZ7DdtG/74Fjly/VQ94hbTQmh6M
         pmtFYX8FLD0tL0fySBKhNlIbV4VluZwX4bgliXFa0g1FWhJuvrz6izLsJwb8iyu84+UZ
         LXfuBFFFK1LuvWrvEnFAaW7hJh4870ByxdQfAZtDUdOBdImh+/g1nj/qsrzTdDi4H2oa
         G/EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783176317; x=1783781117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9xOVRuKFfEvpugkoigwFk6Gb+xTAo+YrZVd7V9k8iM=;
        b=mj3X2Ytv2uJl10pzQXvHCfrL/yHbrnGjhY6os/XF5FwN/hzaL5kNUKdZynWZxTSnvr
         eeM1LDXSUlqrpEMC99soHkR07UZb51oDBHWk/xFa0kBEdHVr2HPyiKWjEWKDW2sC7yBC
         DpejwBHBsJ9cBZXT8fl+83HeVoOGC4+vUGc6ZofqpCu5Zwfyr/WzF0sk2vCr9RoGVkLa
         1CBJM6ybP1TsY2s7IPiEM3nTjpw2bXdDKsl3qw+ZIYt8ZaePulzIxDFg26MlqxO7RVD/
         oi9NVH0hxXud1laOPBTfkpiRt4xE+wRGClmPkI3cjD+GZNhJsHmZfu4zEpbYJuwajkuP
         jmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783176317; x=1783781117;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9xOVRuKFfEvpugkoigwFk6Gb+xTAo+YrZVd7V9k8iM=;
        b=sk7MR6TwjkEwTMmW8aRVVMuFg3AH4dU0VgWxOwcxNG6KBijUxqWusZ3hxxOCEYvG8G
         jLgzdjqGxPgh4uKA6tfuCfOruAhqpjbggMxSCZr/t9TJQJ8SFjborNfuKflGdRppuIFw
         XrCjfu/A8qb3upqAgNkERxtlCjVShAk3xoqxTYmAV65wct8NWIxu2WyJ5GC+kq3SY7Ih
         NItREmzK6Xh/MazB00AS9EZu/W7gFf/rwwcw1dswwTkwNdJbpoOpayqHpnS3Sxx8WKHp
         JjyA8whH7Kdui8GUGNJ/o9W05IVzEAwH8RjVXVY0/kE/uIUFJ5yNKwzjssF9RMwng7V+
         cVlA==
X-Forwarded-Encrypted: i=1; AFNElJ88txtotA4ZQkz50mqHZJakAw2kTQ9WWwYKfMmT28G/kCjLb+G+IK1r2TmiB/2K2IJpJEbWCz0EwfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVh75NwDBTmrOjtjitO/WaSPzoJsA4qLelBxC1bAXfSw7Q2aw
	Mw5CkLxcmxv9nHfPNGh07DHtDPncXMYkYCpxa5k5/XK2otBtiDZDmQyc5533M89sLMgXXk0OjSr
	NVpVWnQh+PaHczMb+HSmd4pYwbmWKyBaY3P4toQ9J
X-Gm-Gg: AfdE7cndStppVa4QF4KO6Qpfc2V5saQZWUGvfBx4PkkA6CZOap7yKxhpOz30DjfEAfV
	YqVaGd0l2bV+yr3PgaXVWpX5c9AxNbON6y0C0PTqCMjdta9X6VjXBYx3naPluh/9/KC3S3QiIiP
	YOeU2et0/ZaI4IvubMW3sw1PgIIOfeG6ORJFMC3EL3tPtUffpNDT0pfMm139W5c2EJyDB8aWLg0
	nepOzVUEYgm43cuPTL7F2ldC63MKfMXD/4vxkXFO8LyqdriJBlxz3MFb0sB48ttbEIsDL5QVieC
	12gWLzpjI3fNvfWC5eAETKzsh8vh
X-Received: by 2002:a05:6a21:4516:b0:3a2:d838:bfca with SMTP id
 adf61e73a8af0-3c03e18c1a6mr3784343637.3.1783176316400; Sat, 04 Jul 2026
 07:45:16 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:45:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:45:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <BN9PR11MB52767E6C22CDF7DAD9D5FF1E8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-21-yilun.xu@linux.intel.com> <BN9PR11MB52767E6C22CDF7DAD9D5FF1E8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 Jul 2026 07:45:15 -0700
X-Gm-Features: AVVi8CeBOQYKqHyO-ZgLrEnt9NfH2sTywpBsyBpG5p82n6nbBzKMaxoqUYDvD88
Message-ID: <CAEvNRgFL_UYz8449z-PJ2ew9x3Ju6qzaBeSxVxLkcNMJeqzMww@mail.gmail.com>
Subject: RE: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on TDX_INTERRUPTED_RESUMABLE
To: "Tian, Kevin" <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, 
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Xu Yilun <yilun.xu@linux.intel.com>
>> Sent: Saturday, March 28, 2026 12:01 AM
>>
>> +static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func, u64

How about __seamcall_retry_interrupted, to emphasize that this function
retries a certain kind of seamcall?

I think resched is part of the implementation, of what's done while
retrying, which might not need to be part of the name.

No strong opinion though. Thanks for considering.

>> fn,
>> +						struct tdx_module_args *args)
>> +{
>
> 'ir' sounds redundant with the trailing 'resched'?
>
> not big deal, just a bit confusing when seeing it in IOMMU side where
> 'ir' also refers to 'interrupt remapping' and is frequently used in
> irq_remapping.c... :)
