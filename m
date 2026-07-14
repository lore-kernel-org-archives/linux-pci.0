Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF935F60E
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992988; cv=none; b=QnfmMISv8NoAAR+Imys2Jgv2IpYA/WXASBJTvSuunF2tgNJsOziU90/voHLTNbjFxdzsyiZg9T0lYfeNd3qe1Klodhh9xUS8OSkJTMWcRY+q9oYG77/8fnCJoB4FQujO3PTs4j5gHWgjAJeWJAaSEzBKhotxajtf5T+pXgVFaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992988; c=relaxed/simple;
	bh=/GMpwucrukky4lwr3G7Boohqm2mU7H4miMN9FIddFyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hPFnuSJC/Hpt8L7U0YQ40/eksUMdeM8FB9gyeOhirbyhfrCqt/9K4xNqbGMty2jrqVVMfwJTL105kbVCvMphQygtgGJMMbH5UV911TN41nrFPlMEGFz7PZvKC7oE+8oLhMpKeIJk+2Dn/kZUdmtz+KoUdaadltXJTagwArzyWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHfLFlns; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHfLFlns"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-69c2f98aa9fso4972339a12.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 18:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783992985; x=1784597785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C+LtOw1NmXZBSXUehU4TQ+aS3E1k4d+esuXPBPSaUXo=;
        b=IHfLFlnspBYNFGoXjsz8txqtIHoHocxx5XAHHoPyGUt9wvo1tTKtHkpkqmFbUYb7zJ
         VZa1sOfBKnlXpsc8R260ZHXcyE0sRkOM7yvNTkRgOPoJH/y3h59wnhdD5D+XIoM40Uw0
         vX/9S4E6YnaiNNIk4/dZNHEIFY2V6guAWq3BIgq9VkvGwYoMiAdnR+wrRyqQCTtVJTOG
         5w6Z7wNg8nXbhbJZzQLJhBTPtMdcryKzJVkF169FHpelZPWirgqtSZjKZvs+aEf0VzZ4
         a4ayf5V+wxaDR+VeZmn5FARLuekb3z9JcstEYJQCAN2JTUjFir1G7EtLg1tMUIjzukcS
         bSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783992985; x=1784597785;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+LtOw1NmXZBSXUehU4TQ+aS3E1k4d+esuXPBPSaUXo=;
        b=HA5QECAMNm4k0ulZGvDKih7Vl8fka2Frx5fK2I0hj1o2rff1gRCiEh5/u4b3XfSRVq
         ot+SOxxXP3cXxALUS1TlOkc7+H9lAQ6aOD3z1TPmeQULGYbzvfYNwc9jsULYUZYDkcDN
         Ux1jkix+vaWTQK53gtZaYiQ+7ATdZ5RLc5pxQu5OmAw4kPRDW7V+oLVOQ1/WK33rODig
         2ZITwpBRvtb+a912hssV98m/ew/nCfTFHizR6tvj31fJlS+iZmS88fqNro2bvQar0iQS
         Sw2vGkh2D4fgXdwZSD4jpAnxB3Pz5vulG4JnNEMFg2vPSeLTBf7BJsKqHDAoQ6NWZwAP
         iRmw==
X-Forwarded-Encrypted: i=1; AHgh+Rquh1VKyS6U8lh1I8hNPKjmsDea/Qz2JVeY/r3mSYftc2HQIZ+5imnHk2iepxSz0PyVruh0bMWNbQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz306mta5LW7hZMg9P8DgTEWwoy4KqPLqfJbemdxD76PAtQHlV
	ZAf4pwhs2bq0pyd/8JEej8PUHlM5d9Iq1tgzEhkOu7kbrcT3zeqsfI/RwyBfL0FX72mOfPSVdNr
	BCpNYe1XJe1CYeEWbjA==
X-Received: from ejcxo14.prod.google.com ([2002:a17:907:bb8e:b0:c16:2bc1:b997])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c18:b0:c15:f360:6f29 with SMTP id a640c23a62f3a-c16619d7dbbmr55427066b.65.1783992984836;
 Mon, 13 Jul 2026 18:36:24 -0700 (PDT)
Date: Tue, 14 Jul 2026 01:36:23 +0000
In-Reply-To: <9huzech6xsrb.fsf@tarunix.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701135015.81937-1-djeffery@redhat.com> <20260701135015.81937-4-djeffery@redhat.com>
 <20260701141145.52A611F000E9@smtp.kernel.org> <9huzech6xsrb.fsf@tarunix.c.googlers.com>
Message-ID: <9huzbjcaxsh4.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH 3/5] driver core: async device shutdown infrastructure
From: tarunsahu@google.com
To: driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Jeffery <djeffery@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, 
	"=?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?=" <mclapinski@google.com>, Jordan Richards <jordanrichards@google.com>, 
	Ewan Milne <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>, 
	"Lombardi, Maurizio" <mlombard@redhat.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
	Laurence Oberman <loberman@redhat.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org, 
	David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


+Adding folks from the original message. Unfortunately, Sashiko drops
the people from the original message.

Tarun Sahu <tarunsahu@google.com> writes:

> Hello,
>
> These most of the errors are due to the device_add concurrently can add
> the device and device_shutdown can access it. One of the reason I think
> a device_add will be triggered while being shutdown is inserting the
> physical PCI device or USB stick etc.
>
> But During shutdown, addition of a new device is not valid. So we can
> add a check something like
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 76ba02c26aa5..c3795fa1cc26 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3650,6 +3650,13 @@ int device_add(struct device *dev)
>         if (!dev)
>                 goto done;
>
> +       if (unlikely(system_state =3D=3D SYSTEM_HALT ||
> +                    system_state =3D=3D SYSTEM_POWER_OFF ||
> +                    system_state =3D=3D SYSTEM_RESTART)) {
> +               error =3D -ESHUTDOWN;
> +               goto done;
> +       }
> +
>         if (!dev->p) {
>                 error =3D device_private_init(dev);
>                 if (error)
>
> We can also partially resolve the races partially by removing the manual
> kfree(dev->p) from device_add() error path. As put_device free it
> anyway when reference to devices reaches to 0. So if device_shutdown
> path takes reference, dev->p will not be released. And few races will be
> taken care of. But this will not resolve the deadlock and other races
> like the above change.
>
> removing the kfree(dev->p) from device_add can be a independent patch.
> like:
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4d026682944f..76ba02c26aa5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2614,6 +2614,7 @@ static void device_release(struct kobject *kobj)
>         struct device *dev =3D kobj_to_dev(kobj);
>         struct device_private *p =3D dev->p;
>
> +       dev->p =3D NULL;
>         /*
>          * Some platform devices are driven without driver attached
>          * and managed resources may have been acquired.  Make sure
> @@ -3824,8 +3825,6 @@ int device_add(struct device *dev)
>  parent_error:
>         put_device(parent);
>  name_error:
> -       kfree(dev->p);
> -       dev->p =3D NULL;
>         goto done;
>  }
>  EXPORT_SYMBOL_GPL(device_add);
>
>
> ~Tarun
>
>
> sashiko-bot@kernel.org writes:
>
>> Thank you for your contribution! Sashiko AI review found 4 potential iss=
ue(s) to consider:
>> - [High] Modifying the core.async_shutdown module parameter during shutd=
own causes synchronous suppliers to skip waiting for asynchronous consumers=
.
>> - [High] Unregistered consumer devices will cause a NULL pointer derefer=
ence during async shutdown dependency waiting.
>> - [High] Adding a new device with async shutdown enabled while its synch=
ronous supplier is being processed leads to an unresolvable deadlock.
>> - [High] Dereferencing `dev->p->dead` without NULL checks causes a crash=
 if a concurrent `device_add()` fails.
>> --
>>
>> commit cf98cdf76df805443cc885868cb3d9e13da5501c
>> Author: David Jeffery <djeffery@redhat.com>
>>
>> driver core: async device shutdown infrastructure
>>
>> This commit allows devices to opt into asynchronous shutdown, executing =
in
>> parallel with unrelated devices after their dependencies shut down. Sync=
hronous
>> shutdown devices will wait for their asynchronous dependencies. The feat=
ure is
>> enabled by default and can be toggled via the core.async_shutdown parame=
ter.
>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>> [ ... ]
>>> +static bool wants_async_shutdown(struct device *dev)
>>> +{
>>> +	return async_shutdown && dev_async_shutdown(dev);
>>> +}
>>> +
>>> +static int wait_for_device_shutdown(struct device *dev, void *data)
>>> +{
>>> +	bool async =3D *(bool *)data;
>>> +
>>> +	if (async || wants_async_shutdown(dev))
>>> +		wait_for_completion(&dev->p->complete);
>>> +
>>> +	return 0;
>>> +}
>>
>> [Severity: High]
>> If a user-space process toggles the 0644 core.async_shutdown sysfs param=
eter
>> from 1 to 0 during shutdown, could this cause synchronous suppliers to s=
kip
>> waiting for their asynchronous consumers?
>>
>> If start_async_shutdown_devices() schedules an async consumer, and then =
the
>> parameter is toggled before the sync loop processes its supplier, the ca=
ll to
>> wants_async_shutdown(dev) here would evaluate to false.=20
>>
>> This would skip the wait_for_completion(), potentially causing the suppl=
ier
>> (e.g., a PCI bus) to shut down while its consumer is still active.
>>
>> [Severity: High]
>> Could this result in a NULL pointer dereference if the consumer is not y=
et
>> registered?
>>
>> The device_link_add() function allows creating links to consumer devices=
 that
>> haven't been registered yet, meaning their dev->p is NULL because
>> device_private_init() hasn't run.
>>
>> If wait_for_shutdown_dependencies() is called from the async pool, where=
 the
>> async argument is forced to true, the wait_for_completion() will
>> unconditionally evaluate &dev->p->complete, crashing on the NULL pointer=
.
>>
>> [ ... ]
>>> +static void __shutdown_one_device(struct device *dev)
>>>  {
>>>  	if (dev->p->dead)
>>>  		return;
>>
>> [Severity: High]
>> Could this cause a NULL pointer dereference if a concurrent device_add()=
 fails?
>>
>> If a concurrent device_add() fails after calling kobject_add(), its erro=
r path
>> calls kobject_del() and then frees and nullifies dev->p. Evaluating
>> dev->p->dead without checking if dev->p is valid could crash here.
>>
>> [ ... ]
>>> +static void start_async_shutdown_devices(void)
>>> +{
>>> +	struct device *dev, *next, *ndev, *needs_put =3D NULL;
>> [ ... ]
>>> +			needs_put =3D ndev;
>>> +			spin_lock(&devices_kset->list_lock);
>>> +			/*
>>> +			 * If the next device has been marked dead while the
>>> +			 * spinlock was released, it may no longer be on the
>>> +			 * devices_kset list. Restart the list walk to be safe
>>> +			 */
>>> +			if (ndev && ndev->p->dead)
>>> +				goto restart;
>>
>> [Severity: High]
>> Could ndev->p be NULL if a concurrent device_add() fails?
>>
>> If start_async_shutdown_devices() obtains a reference to next via
>> get_device(), and concurrently device_add() fails and clears dev->p,
>> reacquiring the lock and evaluating ndev->p->dead here could result in a=
 NULL
>> pointer dereference.
>>
>> [ ... ]
>>>  void device_shutdown(void)
>>>  {
>> [ ... ]
>>> -		shutdown_one_device(dev);
>>> +		if (!wants_async_shutdown(dev) || !shutdown_device_async(dev)) {
>>> +			wait_for_shutdown_dependencies(dev, false);
>>> +			shutdown_one_device(dev);
>>> +		}
>>> =20
>>>  		spin_lock(&devices_kset->list_lock);
>>>  	}
>>>  	spin_unlock(&devices_kset->list_lock);
>>
>> [Severity: High]
>> Can this sequence lead to an unresolvable deadlock if a new device is ad=
ded
>> concurrently?
>>
>> If a new device 'C' with DEV_FLAG_ASYNC_SHUTDOWN is added via hotplug
>> after its synchronous supplier 'S' has already been popped from
>> devices_kset by this loop, 'C' is appended to devices_kset.
>>
>> 'S' will call wait_for_shutdown_dependencies() and find 'C', blocking on
>> wait_for_completion(&C->p->complete) because wants_async_shutdown(C) is =
true.
>>
>> Since 'C' was added after start_async_shutdown_devices() ran, it is not
>> running in the async pool. Because the sync loop is blocked on 'S', it w=
ill
>> never reach 'C' to start it, deadlocking the shutdown process permanentl=
y.
>>
>> --=20
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701135015.8=
1937-1-djeffery@redhat.com?part=3D3
