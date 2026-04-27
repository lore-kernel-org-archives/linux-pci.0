Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1A3AA517;
	Mon, 27 Apr 2026 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324302; cv=none; b=UkRgIth2Q+ckQZCU/s7M2JRVALlD2N3RchGxt1oyBOQ5u0p75kUlXceLafs7vbsIgpOPnxzpWUYVsD6u01ZEa+cgTxyZ1st76eZrXYebNxux8q/6D/wK+/5Ivj+BRrdjqXsrJBWEhAxuPMig1QfHd642oQ8IdtvMjy6gcQCM7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324302; c=relaxed/simple;
	bh=eCpFyIQwjTL0FLnJ9C988NSyGD1GctZLUSJP2KJCfYw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Wa9YtqT7Mm8zrg6p/8tyfB39yuEEuzWfVakh1rRIq3LIrQ8U4EAuWJ6oIwokDn+obFnEjUXgOGGipT7oHMQo9ZcOyI649r4Ls/Y1vxWfRgd6IQ6sYks4DmQ6IVZoW7909i1imHwcseoxwVYBCIyaenOu1tGw5CYex8FWvnhxH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbktTdj3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbktTdj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F46C19425;
	Mon, 27 Apr 2026 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777324301;
	bh=eCpFyIQwjTL0FLnJ9C988NSyGD1GctZLUSJP2KJCfYw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=EbktTdj3IgWyZPwRQYCkuNqeWZ8NhoHT4Y1GB1m6nNjaHWbkcZHg8PHEEFlzuiQHD
	 69S5nRps+E3F1e3GxY+aOEQ8Be9iw/PYFHHHE+mCLi6i7wT0myhDrM3gvF9CErRFYO
	 52JAATsEg8TXuAuvViQJCroYOS2HEsea5scR6Hs7FVjWLztCIIY8HLy775FdGHXxaZ
	 2UDod8oYI2jVV6+vEyUXVAJE6nqOCBfa7tHO0xQuX4Ze2WrZk39KCgYAsHnzKpG1w0
	 XDGq/9iyeAYoqW2teG8iOHqLgGrtjie/JHaOnhMCO3S37dGHcx51B9DVYIgN4oKKJm
	 I5rWtjgDYWxbA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 23:11:38 +0200
Message-Id: <DI48VQVY1LJN.3PKEQB6KX0S3J@kernel.org>
Subject: Re: [PATCH] PCI: Init driver override spinlock in new_id_store()
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Gui-Dong Han"
 <hanguidong02@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Alex Williamson" <alex@shazbot.org>, "open
 list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, <dmatlack@google.com>
To: "Samiullah Khawaja" <skhawaja@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427193139.2109938-1-skhawaja@google.com>
 <DI472FJ8UOG4.1JGTQK7W1RAX@kernel.org> <ae-_EmuuoQTqD6wg@google.com>
In-Reply-To: <ae-_EmuuoQTqD6wg@google.com>

On Mon Apr 27, 2026 at 10:36 PM CEST, Samiullah Khawaja wrote:
> On Mon, Apr 27, 2026 at 09:46:20PM +0200, Danilo Krummrich wrote:
>>On Mon Apr 27, 2026 at 9:31 PM CEST, Samiullah Khawaja wrote:
>>> Fixes: cb3d1049f4ea ("driver core: generalize driver_override in struct=
 device")
>>
>>I don't think anything is wrong with this commit, and it seems unrelated.
>
> I will remove this one.
>>
>>> Fixes: 10a4206a2401 ("PCI: use generic driver_override infrastructure")
>>
>>I'm also not sure that this one contains the root cause, despite revealin=
g the
>>actual issue, more below.
>
> I see your point. I understand the actual issue is that the temporary
> pci_dev struct was not init and that was added in 2014. I added this
> since this is where the regression happened.

Yeah, I did not mean to say that this tag is wrong -- it is where the regre=
ssion
happened. But it may be worth adding both, this one and the one that did om=
it
device_initialize() in the first place.

More in general, this can matter because it influences how (far) it is
backported in stable trees.

While rather unlikely in this case, there could be a subsequent fix that is
incompatible with device_initialize() not being called that may be backport=
ed
event further.

This would not regress in recent trees as it would have been fixed there
already, but might regress in an ancient stable tree, that did not get this=
 fix.

>>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>> ---
>>>  drivers/pci/pci-driver.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>> index d10ece0889f0..5f453213b8c5 100644
>>> --- a/drivers/pci/pci-driver.c
>>> +++ b/drivers/pci/pci-driver.c
>>> @@ -215,6 +215,11 @@ static ssize_t new_id_store(struct device_driver *=
driver, const char *buf,
>>>  		pdev->subsystem_device =3D subdevice;
>>>  		pdev->class =3D class;
>>>
>>> +		/*
>>> +		 * Initialize the embedded struct device driver_override lock to
>>> +		 * avoid the lockdep errors.
>>> +		 */
>>> +		spin_lock_init(&pdev->dev.driver_override.lock);
>>
>>Can't we just call device_initialize() and set pdev->dev.release to a new
>>function that just calls kfree()?
>>
>>This way nothing of that kind can ever happen again; it is hard to predic=
t that
>>a device is used without ever being initialized.
>
> Agreed.
>
> yes we can set the release function and call device_initialize().
>
> Should I send v2 with something like following:
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d10ece0889f0..634b4311bf5d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -179,6 +179,11 @@ static const struct pci_device_id *pci_match_device(=
struct pci_driver *drv,
>          return NULL;
>   }
>
> +static void _release_temp_device(struct device *dev)
> +{
> +       kfree(to_pci_dev(dev));
> +}
> +
>   /**
>    * new_id_store - sysfs frontend to pci_add_dynid()
>    * @driver: target device driver
> @@ -214,11 +219,14 @@ static ssize_t new_id_store(struct device_driver *d=
river, const char *buf,
>                  pdev->subsystem_vendor =3D subvendor;
>                  pdev->subsystem_device =3D subdevice;
>                  pdev->class =3D class;
> +               pdev->dev.release =3D _release_temp_device;
>
> +               /* Initialize the embedded struct device. */
> +               device_initialize(&pdev->dev);
>                  if (pci_match_device(pdrv, pdev))
>                          retval =3D -EEXIST;
>
> -               kfree(pdev);
> +               put_device(&pdev->dev);

Overall Looks good. Not sure about the _release_temp_device() name and I th=
ink
the comment above device_initialize() may be unnecessary, but I'm pretty su=
re
the PCI maintainers will have an opinion on that. :)
