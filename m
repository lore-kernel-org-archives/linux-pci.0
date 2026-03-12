Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD8344DBB
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322765; cv=pass; b=Pb+qFiBE3g4iCQ4vGnQz7FUOO0y1LWVbtIyrChVI/nNLSCcKRB7RQYwJrU9oFJpFvrV82i6RsyDuIOecAo4MzdT0fLyybF4s3uYeH8WASN7yrDL8PXO7fLJr2of6dFrpHEnmi5csrgu+9+JSeECi1JXz6QGUH0775wpOUqQMe8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322765; c=relaxed/simple;
	bh=L69QmC18hapMhcCCM9aOUH8w0vMV/TSuAPEAAljzmjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auyh9uCDqtQiAdaKPdHZJFKtLVi4kuwUM473GIVPGp16AJDifc+vapHseVwo/8ZIuGlEkZlwrhRTKOIQbajmbORsDRXItCbx5K1kg+8o85sMmxni5eNnriWgQnaJ8nrVvfM5ynrLR6F1cY8rpuwq3oA+ylcvkWEbCKXlhMGSHF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbWeDCcK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mFrD7SDV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbWeDCcK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mFrD7SDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773322763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1afq9gHFIfQK6ABVrm5mHYxKeNKd2BXTj6Ir4QwH/s=;
	b=MbWeDCcKfnHQIkmkxsGJr4MJpn9HmcoJblyMLZVe4leqTbOnD9921K7Hq6ZIqG4rK5p+Vy
	RiCuMbwXuSaF0qkekY5EbtMBa+Tea9GgrYetc17tbkrvBO0t4SrytwcKqCglAcxzysF00C
	CGsmf44BpABSjpzJuyjj5l4Y4tx4tDM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-2hZcbDZmPMGSMo850bjgsA-1; Thu, 12 Mar 2026 09:39:21 -0400
X-MC-Unique: 2hZcbDZmPMGSMo850bjgsA-1
X-Mimecast-MFC-AGG-ID: 2hZcbDZmPMGSMo850bjgsA_1773322760
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-385c90cbca6so5189501fa.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 06:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773322760; cv=none;
        d=google.com; s=arc-20240605;
        b=WIKyitetzLXU0ueTj5NL+z4i/ogOGOq+hUb0c3toXQiIzyaW77gtMHwkCDrlvVDUEI
         Xcapc3emOSkkm/xdgJQReRXYnup96nwX3CkdxKo6lHpmWEQhhmlhdnZg3lmDAmP8aRWA
         OSaknAs8CKelCRbqPU6/o2s86ZT56L8pBVc7C81c+j0eVEIoxofV0sYHCXz1BTdKpkRq
         RwjW5dEyGosBGlFKTRySAgsrJxBam3VKs5axsW99/yNuP2eSi7NG1kRjgbLwDXDPc/Ly
         oW+AqIZs6HkGORKEiWzEk/TFZTlYsTvoShYSKjWbztQbvDgaVY7ffYGpDc526RCghGgG
         JPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1afq9gHFIfQK6ABVrm5mHYxKeNKd2BXTj6Ir4QwH/s=;
        fh=tjRqqe+E/Y81jY1qjx+5otb+hE05j/F4DhRrVkhosRE=;
        b=MoKvMg31IqZiAI0L/FEcjyRcExwrTYaAGy8EP+xIK7qf9aDLKcb/Lz2Tn0s2pa7ZU+
         YVMj6sPHlpKdqJFKsc67Tu32xe4Oako6ptrrvnEbLhZvjEEpwwTfDZecBoRNszkVpiON
         EYRsG7Q53d0+sgsSj+1RVb/nJXgqUZD0bxhVkFgBo5r1kqDP18GkkfP4g2M5xlqTQnWa
         Mn/uMvoCitqGO9IDOXelKoEc9cWVDyuJcZ+jahvwZcFNGZCkSwtBqPbkKqEHnm8/rIhp
         v0D0FWuNpbdNwzGciVyyrlS4lH6RThRvWRw18neNYE6Yjm3QWY9tG4PhI3N/NDThrlL+
         1oRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773322760; x=1773927560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1afq9gHFIfQK6ABVrm5mHYxKeNKd2BXTj6Ir4QwH/s=;
        b=mFrD7SDVKrdE5gTc1qr2gdfcWS/Wnz309/xCpxkYFbwAeth0t56LQz9Q0QwBI7qsko
         bO8qmkUABZ4uZNPSMKbD4NGF59YaQxbsPQ2rQT13sZcHCOId0BBNdaagQOi9x0bBaxdP
         TWYR8uLYUQE3eUOZFFdTbKnnb4GsdlxDjP3zUmWla0BkqP6pExDLb+0R9JGr3oGdajOJ
         0zY87aMjBCQPVK7XRdxOlw+I/kimdz+n5lFjJ2gFgSI7zsNTCriHFfhjGnvhZPPBR0R0
         z4rQnlDanMfkBrzQ+PJdnX0BMMrxDTYyzlwnfZ+9+BWlIKyqGXriD8UeiJLZhZmkBjPl
         JYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322760; x=1773927560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1afq9gHFIfQK6ABVrm5mHYxKeNKd2BXTj6Ir4QwH/s=;
        b=anJS3H0rdhL38mESVRrEJ3CVzxx+RnC3aRyCXX3cPzz6SdmGwEJbnKHYoUSYhKCxHG
         9LLaNtfD/o+eW/X4SNkI2SWPXmhbwEDijlJMHWtxglbKasMvNxzYSHcgRM3/sfD3/CiM
         NE2/dgFz6PfQntC29ZwTiLp4rWLmGLbgE+2E0W1asHrf7D8JPexqBcgsCkB8GId6iyoD
         ABq1uxBSSWaQwkfioRvUjNs1PZdq9fvFxJHDhgTYsOxonBGEL5DmKJjKn3oEuS5rCP8p
         pTiZLPqO50jA4pJxv165CCoSjRRzhEM6LrMhNC9Wk7qSL5wunw7D5MF3LL9qjorR1Pwi
         BHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJy4tjIITzNPzBgiv5tPn96ddKcyBd+jLbKjoFCCeOhdBmmqiStUPrIMwfj6DEOuYWOrfFjAcYpZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYPDaeEz8HDf6faQNY3ZLnVKW3CRIVpJuHwZL2c73tU9Nr2wa
	M/EAf74V7lRiPBPLHzE+HMnKcfIkirHzRe7CcRPUSMVn5RRVYZA1WZ/1N3Osv5iihvGlvnbC9EU
	3QNzHcBNG8qfbvcgrHgLLTgAxaIKtokDWcsG7uxCVuvvspfO2VWcCNh1fnxyYwbpkSzZpzh4Fom
	kSt+P9Tuaq203H1JTF4CwXCA4WUx6VQUXcIVH3
X-Gm-Gg: ATEYQzzw/plYbMZiVlL3Bc80pjR1wKCk5J87tOCf3SxWVZtM/EdXPZUsXvkcWuzIM9F
	QUrdOjqqGwqiQ1Wpz3j5vmJJhfiDfim9emKU0TpT9UtvaOkWo8CBzRfNcxPeB/Ju2Y5pgQncgdX
	TNuEyivJ7QHvMYkTXSdm8j8DVddmJp20PAtkcgS1vWP/yTNWs8XzA8MHWt37WJH+CuOG7mWTOSh
	zJo
X-Received: by 2002:a2e:a991:0:b0:38a:69ae:ed76 with SMTP id 38308e7fff4ca-38a69af0e32mr23484821fa.8.1773322759825;
        Thu, 12 Mar 2026 06:39:19 -0700 (PDT)
X-Received: by 2002:a2e:a991:0:b0:38a:69ae:ed76 with SMTP id
 38308e7fff4ca-38a69af0e32mr23484641fa.8.1773322759293; Thu, 12 Mar 2026
 06:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311171209.9205-1-djeffery@redhat.com> <20260311171209.9205-2-djeffery@redhat.com>
 <932d4e59-395f-4022-a2de-874fdea778ac@acm.org>
In-Reply-To: <932d4e59-395f-4022-a2de-874fdea778ac@acm.org>
From: David Jeffery <djeffery@redhat.com>
Date: Thu, 12 Mar 2026 09:39:06 -0400
X-Gm-Features: AaiRm50cC3-HopgnDbEpZBKck8Qg_3xXUFA0iihGZz6Xo1ScI6fOim-Jwqz1X4I
Message-ID: <CA+-xHTFnOtFqFeH=Va1vTC3qaa2J_tDCfpdq-RdHFFbByoNobg@mail.gmail.com>
Subject: Re: [PATCH 2/5] driver core: separate function to shutdown one device
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 2:03=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 3/11/26 10:12 AM, David Jeffery wrote:
> > +static void shutdown_one_device(struct device *dev)
> > +{
> > +     /* hold lock to avoid race with probe/release */
> > +     if (dev->parent && dev->bus && dev->bus->need_parent_lock)
> > +             device_lock(dev->parent);
> > +     device_lock(dev);
> > +
> > +     /* Don't allow any more runtime suspends */
> > +     pm_runtime_get_noresume(dev);
> > +     pm_runtime_barrier(dev);
> > +
> > +     if (dev->class && dev->class->shutdown_pre) {
> > +             if (initcall_debug)
> > +                     dev_info(dev, "shutdown_pre\n");
> > +             dev->class->shutdown_pre(dev);
> > +     }
> > +     if (dev->bus && dev->bus->shutdown) {
> > +             if (initcall_debug)
> > +                     dev_info(dev, "shutdown\n");
> > +             dev->bus->shutdown(dev);
> > +     } else if (dev->driver && dev->driver->shutdown) {
> > +             if (initcall_debug)
> > +                     dev_info(dev, "shutdown\n");
> > +             dev->driver->shutdown(dev);
> > +     }
> > +
> > +     device_unlock(dev);
> > +     if (dev->parent && dev->bus && dev->bus->need_parent_lock)
> > +             device_unlock(dev->parent);
> > +
> > +     put_device(dev->parent);
> > +     put_device(dev);
> > +}
>
> Please keep the following code in the caller:
>
>         if (dev->parent && dev->bus && dev->bus->need_parent_lock)
>                 device_lock(dev->parent);
>
>         if (dev->parent && dev->bus && dev->bus->need_parent_lock)
>                 device_unlock(dev->parent);
>
>         put_device(dev->parent);
>         put_device(dev);
>
> Additionally, please make sure that the caller is made compatible with
> lock context analysis (see also
> https://lore.kernel.org/all/20250206181711.1902989-1-elver@google.com/).
> All that is required to make this code compatible with lock context
> analysis is to organize it as follows:
>
>         if (dev->parent && dev->bus && dev->bus->need_parent_lock) {
>                 device_lock(dev->parent);
>                 shutdown_one_device(dev);
>                 device_unlock(dev->parent);
>         } else {
>                 shutdown_one_device(dev);
>         }
>

This would also need to either grab another reference or move the
reference drops since shutdown_one_device may drop the last reference
the task owns to parent and dev. Since shutdown_one_device ends up
called in 2 places in the next patch, perhaps would be best to split
the bulk into another function, then have shutdown_one_device be a
wrapper like:

         if (dev->parent && dev->bus && dev->bus->need_parent_lock) {
                 device_lock(dev->parent);
                 __shutdown_one_device(dev);
                 device_unlock(dev->parent);
         } else {
                 __shutdown_one_device(dev);
         }
         put_device(dev->parent);
         put_device(dev);

David Jeffery

