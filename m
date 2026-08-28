Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A243515D1
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932907; cv=none; b=CeIbY1W8be4/OtJ8rpV6W6HUXbOZUW7b4xGRRUJ9O1CHNydxE5+09CxNNGY6QlRDxtwFfzRTMLp/5jZ82gmfjnlqCHgcw16jSyktconSpttXvli113kftq9kyOunsAASGXV2AHE5HAOTqy1t3D+FfYMZwGXnvJBp2bFG7c6oODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932907; c=relaxed/simple;
	bh=UuWnHtXL8N/w/Q5WNTbDJxeFR+DQc7c1YtM6Y9NEeTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ovp8WLmZzTDDDsKDDoVCgkCKHkOqVXUbngHGKpJfvDW+RiVQtk5cbQ3oPmLZmvmbhkZUGqt6jWeUiDr5sqMRaheru+CGSOGojucm9tNchBBuPRk6JhngtPGr53UG4Qv+NuQe+JlHz6LJG/fO6q+1uUj3e9YMa7oDrB29vYrafd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnLREiv6; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnLREiv6"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c253185765dso95488266b.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787932904; x=1788537704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rbwr+K5nPn6tIRCwsto5KEIPiqdePxzLIo1QhD83FDw=;
        b=DnLREiv6DOftqMow2FPIZ5x9Xx0gAKzmcnaAj2IQcYhJ0Meos6uCzsdSGHHQ3a9k3W
         ECMqr4J2By/m+LevKjkPi1zvjCnN3sI45kOgBqOkxQNSrNLztgwxk4NI1H92jxUo7JzT
         EIYwPqwYoOgXH3x8jb26DONwnkOOkWOJL4XqgMlVU9sRqTY0PPqPZvL2MTpUAR2m6ecQ
         VdxsoSSBIv+VSWF6XX8swWtP15116RVoWFm/OiHEpLPRMT36pAIbi9kmWg6ifBCHnM2U
         C4hgXe0m2GHZvY5S0Uz4zL5WByuIEDu9ZYPJLGZs7EoASriU3CjXVXFToKUQKfr8geE+
         T9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932904; x=1788537704;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbwr+K5nPn6tIRCwsto5KEIPiqdePxzLIo1QhD83FDw=;
        b=ZmoLp090uySQ1OELQuZF+40rfiSIOIdI6gRvzzRRCMCPr8HlsEsvP0Gjl7kkx1eucz
         xeUMV5ct5Iakt58V04UBjjHvAIeV9VfLJTtxzdfyb9QKgfBa5aIlH/NCDdOS54gy6qs7
         hv65f8fy/C7Jftw/SFvSiqmPRR4DzuDVCAuHmxn8ablRLYIchOvtDvqCqUCGC5y5ShDc
         XkwCmJ219inTNOixJCdRwQPlK1xf6ezImFSif05MDiDqQv2ckjf93v26L1GUgYztZhLf
         WtOXzNOajqOuRifpJkcPx4Mvv5uCBZhq+RHsmFxCI09ISV+0pQSi4wciy7CPJXQz0FLH
         B6Ug==
X-Forwarded-Encrypted: i=1; AHgh+RodxWD3/3gGM2o/4iwRmRLlWq+fuNRN7c3xnFJaRfErD9fzjOGgUEHVoa3/6YpQJ9NZGQzSPYbq/Oo=@vger.kernel.org
X-Gm-Message-State: AFuF++l+itqubheRRq0aktguvKRow8/1vCXopdeR1zdIB6mxgPgPtjCI
	p/50yWd58tJLX/wId/ekjLxPjhyDe1JirtHR57vqbBkm/NHDf0GNxf4oMKannVYUo6ojhaMMJqW
	bInZGoc5oDzqXzYO5BQ==
X-Received: from edj18.prod.google.com ([2002:a05:6402:3252:b0:6a0:9689:91c0])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:455a:b0:6a3:f74d:6a47 with SMTP id 4fb4d7f45d1cf-6a60d157efamr5227378a12.0.1787932903626;
 Fri, 28 Aug 2026 09:01:43 -0700 (PDT)
Date: Fri, 28 Aug 2026 16:01:43 +0000
In-Reply-To: <20260821144335.1BE1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260821142414.150892-1-djeffery@redhat.com> <20260821142414.150892-3-djeffery@redhat.com>
 <20260821144335.1BE1F1F000E9@smtp.kernel.org>
Message-ID: <9huzh5kez120.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH 2/9] driver core: prevent device_add() during system shutdown
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev, David Jeffery <djeffery@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Race condition in device_add() abort path during system shutdown=
 leading to Use-After-Free.
> --
>
> --- Patch [2]: [PATCH 2/9] driver core: prevent device_add() during syste=
m shutdown ---
> commit 17748fb46ccfdb0adadd634adbfe70a9fd601b9a
> Author: Tarun Sahu <tarunsahu@google.com>
>
> driver core: prevent device_add() during system shutdown
>
> This commit adds system state checks to device_add() to prevent new
> devices from being added while the system is halting, powering off, or
> restarting. It re-checks the state under devices_kset->list_lock to
> avoid a TOCTOU race window with device_shutdown().
>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
> [ ... ]
>> @@ -3699,6 +3720,18 @@ int device_add(struct device *dev)
>>  		goto Error;
>>  	}
>> =20
>> +	/*
>> +	 * Check system_state again under list_lock to prevent a TOCTOU race
>> +	 * where device_shutdown() runs concurrently and misses this device.
>> +	 */
>> +	spin_lock(&devices_kset->list_lock);
>> +	if (unlikely(system_is_shutting_down())) {
>> +		spin_unlock(&devices_kset->list_lock);
>> +		error =3D -ESHUTDOWN;
>> +		goto ShutdownError;
>
> [Severity: High]
> Does this error path introduce a use-after-free race with device_shutdown=
()?
>
> If device_add() successfully links the device to devices_kset->list via
> kobject_add(), device_shutdown() could concurrently run and pull the
> newly added device from the list:
>
> device_shutdown() {
>     ...
>     spin_lock(&devices_kset->list_lock);
>     ...
>     dev =3D list_entry(devices_kset->list.prev, struct device, kobj.entry=
);
>     ...
>     list_del_init(&dev->kobj.entry);
>     spin_unlock(&devices_kset->list_lock);
>     ...
> }
>
> If device_add() then resumes, acquires the list lock, and sees
> system_is_shutting_down(), it will jump to ShutdownError and return
> -ESHUTDOWN.
>
> The caller of device_add() will typically treat this as a failure and
> free the device and its associated private data. Meanwhile,
> device_shutdown() is already outside the lock and actively executing the
> shutdown callbacks on that exact same device:
>
> device_shutdown() {
>     ...
>     if (dev->bus && dev->bus->shutdown) {
>         ...
>         dev->bus->shutdown(dev);
>     }
>     ...
> }
>
> Can this lead to device_shutdown() accessing freed device memory?

We can make device_add and device_shutdown synchronise like

+device_block_adding();
+wait_for_device_add();

calling these two in device_shutdown similiarly we have for probing.

~Tarun

>
>> +	}
>> +	spin_unlock(&devices_kset->list_lock);
>> +
>>  	/* notify platform of device entry */
>>  	device_platform_notify(dev);
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821142414.15=
0892-1-djeffery@redhat.com?part=3D2
