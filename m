Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9F4657F3
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626243; cv=pass; b=AY8WvsMLj2/DVLFtO2LavSN8r8EnVWT8ydsRp+pyhybbTU+k2GzyyOG5mqaM0512TIXyMZuQUZx1+TFQ8cv77FZ7NvlyXWT2hrrv71IPZYOTm/zBrPEe4DtMxxUCh25cGCsRirR5yOpZY4EPaoGbjnB3O7ebWV/mdYK75nUp3+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626243; c=relaxed/simple;
	bh=1jkLbkvafGxacZOEb64OWdl56xQz9vDwq0HVA7p3CPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXWy7kdrvmxrL0K+Zq2nzd11fntBFIK104QwkmwTcGH7AbY8UoKNolUXWlN4+8iOllCTumiFSPibCtAvyDf0mmJt52rmiaN7hQSQ/dq25NxmDGCY/g6vc1s3r8OgX7lp9dLG3jhm7GPz1xFOqRr+bWMxS4ZngnmghalU/bLqbT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GeOOJrs5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tx7ThHbP; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeOOJrs5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx7ThHbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781626240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYzDz6Op63i1b1Es07mE9ik1AD2u9zxTqg55lTEbStE=;
	b=GeOOJrs5itR8frZ4PMLlOxSdv2lGquBs8PP9yvf7NTszKgz2+3IIfjIIc8xQFXK18iAJXG
	Opanv/H0pgij3ilgwA+H2waH2q9oPJwQ5h76nFLulKXf74OPUAbuTXWwoVMQRdd+mDjnwf
	7qMAxk7wyf8oV4EP7JIVJlq+Ng8Fc3s=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Hbj3dqTROwug3ze99-9hRw-1; Tue, 16 Jun 2026 12:10:36 -0400
X-MC-Unique: Hbj3dqTROwug3ze99-9hRw-1
X-Mimecast-MFC-AGG-ID: Hbj3dqTROwug3ze99-9hRw_1781626236
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59eba324559so2799569e0c.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 09:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626236; cv=none;
        d=google.com; s=arc-20240605;
        b=Ahor8K6XTDEtEmdNULl4IFGWv3z4IMzuteawDfQp3GV1tPM18mGcvC+WcXsEJIAoOH
         SCs3lOM5nThlrsL8Vm/2ZTckUZa9LSTiS5HAPPD6SW0mvIrRVrkoWimwrBAHy0XJ0GMe
         hVwGj5Uq7noACNoiOn3Br6X4u3ludKBLLwN26jjvEegxodwoabGte881HK+3Q4JCHbkI
         Sc90pCCm1r9vFdL7I69evDFoDK5ccYw9J7iaXuMa7o67PqYckaVgDa+IuvPomjDZMaSO
         vpp77pjsh+IMgQuG1bmsNC9zyeayf6y/KGqusr9X36o/e7tBpPKQfyE0myunipeSkeI4
         G4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYzDz6Op63i1b1Es07mE9ik1AD2u9zxTqg55lTEbStE=;
        fh=+kZPK2aSgkTwFLxa2/5IBXOJvjCThj9Wh9tsO4zCMJ8=;
        b=QuGV15tHhnxlYYUp2jvs/0oEKPso6t55ITAvBRC8woHAa6uqrELPGVpgZfkBDrT7Wn
         maQnIeHjsUGOHrBvAZyHA2X5nuXVmCwiLCzpcU697SxqC6pVIRtMup6wX4AOUthY25Nu
         8gCPDXHG/+3fLb/lFYOgJqcOOTZt3LDPUaKKGxhl3F4MljC1FJYbeQC2mRWUJMRxNjtI
         wT07rnFWkb5gnLKa4BHNkOuogpm2AVvwDjmN4ClPWE7AEGWVmuuXM3aAGg/qVqWxsgk+
         U8D9kBwJMyZNb8xWOJvsadwROgklDMHNcB6mE0lK6fg2uEanmINd4/BRoz47Qz5EoEsE
         UDxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781626236; x=1782231036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYzDz6Op63i1b1Es07mE9ik1AD2u9zxTqg55lTEbStE=;
        b=Tx7ThHbPbazhZDm1sU44cWLdIJAlcFra/JoYlqk6GYGPoil9BrtG/yhlHffLVSUQfh
         svbkek/Ncosy+mu7mTneLUAessRMAQwQaMgckmPvT/ViPaBWczUnQ129JPSxxfYtxrkZ
         KUH0Mm2eRg0Ky0vDEhaHB5L6r/fZbBxVs6kGRaHBcY5KS3H1BzKFdETDY3S/1iVYimdo
         pa+S6GUSFS197t13L/IGgM52nRd7hdJ0hWz6O4kmNPVSkIylYKTuw7eJLQbp5v+baKCY
         lSMw5UBUZ5V+jNweSUNnommky99APfYrXgkCNzHXW+58NEq1SccrxVdPGKfgo6VHIPT2
         poww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626236; x=1782231036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYzDz6Op63i1b1Es07mE9ik1AD2u9zxTqg55lTEbStE=;
        b=bBLV5Ay0R0tXIShlk0pxiroJYcp5xIGTV9NkxdWzGZV13sGb+xkHoWl5aC3hlYb5h6
         ZbXMU4bTLM1odZNh5/AhX32nLjHXg3ELcsoV7L1CsfZR5T8OQEqJdI3E/H+z/6m7UUx5
         3/8eE3oQOf5zP3sCoZQyHw9oolTbP8iYGeyo4Rp6CLurJIrcVpoJ6hnEU38M/jNWH3vi
         6zXCDsCkzfA/Hn8g0ecaogXGw4u7zHu1kFGbs0XbRuI1rtRygjbj/YbiTL6J1gg6qbrk
         oEm7BhiGjC2/aWusIgoDHb4YbfIyU/rhY9qOX5O1kJGcgEH3vgTRKbuhCx5/0nwPRo2u
         IHow==
X-Forwarded-Encrypted: i=1; AFNElJ/Pkcxn4kpXCnHxBbIYtZftR4KwqMoMrkxrcMnLyglT7Fil+K5u1jsD51uLQL5ruywRBZuOfrGXz+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSh0ZezvOd3H26kiYWQ7f35F4FLHJ/fmBCR94/QdxaDfkS1LG
	h4HVoOefgbowFsj7Uc1zGF9P2q2TOwkEZmAXKaEfj4C5PWfVplsAKT+mOmwMQx731XlCL6P6Ttl
	alahHaCE8r8PjTTS+UlPER9C0Nc4s0AawScseG4VU53b73NCIs4+FxV00KViO1I4XSKgrm8kxFi
	jkJAYMymYKDD0JtmxGZQLuJkA9jbjRVuaa0+Ul
X-Gm-Gg: Acq92OH46MpjxOBtbmTGXRtfgRT7Iaj92LqSJcJcLaMjPtUvLu4Om0+89fZjGf2RdcJ
	1JsFdc5ItIgVwCPCBia16dmX8Va3vChSTuL8bjVs9umdjnS410DtVY025f7ck8oUdPccRwXocvb
	Wya16XFlhShe7x8yUYKDhNN5H4h9oU7Cg/Vz+9zwMt92lzmPNJcpYQrul6so0vb/vZAR6SZQTKh
	yOSdz7dq2vRHLm9prTniSFESKkUbCl/LvnRfRZihauWetTzeZj3MCZWGO2x
X-Received: by 2002:a05:6122:2886:b0:59e:b127:fc6f with SMTP id 71dfb90a1353d-5bbbe46f083mr136472e0c.2.1781626235833;
        Tue, 16 Jun 2026 09:10:35 -0700 (PDT)
X-Received: by 2002:a05:6122:2886:b0:59e:b127:fc6f with SMTP id
 71dfb90a1353d-5bbbe46f083mr136421e0c.2.1781626235332; Tue, 16 Jun 2026
 09:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616152219.6268-1-djeffery@redhat.com> <20260616152219.6268-4-djeffery@redhat.com>
In-Reply-To: <20260616152219.6268-4-djeffery@redhat.com>
From: David Jeffery <djeffery@redhat.com>
Date: Tue, 16 Jun 2026 12:10:23 -0400
X-Gm-Features: AVVi8CcAVaHcV51QjovJA8RG5VnZNDjVsIyhw2UF22IaX5vguXNcx3MAVGE5xto
Message-ID: <CA+-xHTEbjiUXC0JHoSsyzNRx4CC8QxwQi92op0GxVHZTVskeiQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] driver core: async device shutdown infrastructure
To: driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:23=E2=80=AFAM David Jeffery <djeffery@redhat.com=
> wrote:
>
> Patterned after async suspend, allow devices to mark themselves as wantin=
g
> to perform async shutdown. Devices using async shutdown wait only for the=
ir
> dependencies to shutdown before executing their shutdown routine.
>
> Sync shutdown devices are shut down one at a time and will only wait for =
an
> async shutdown device if the async device is a dependency.
>
> Enabled by default, async shutdown can be explicitly enabled or disabled
> by using the kernel parameter "core.async_shutdown=3D<bool>"
>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  10 ++
>  drivers/base/base.h                           |   2 +
>  drivers/base/core.c                           | 127 +++++++++++++++++-
>  include/linux/device.h                        |   2 +
>  4 files changed, 140 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b5a51a36a048..dd912f47ace4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1019,6 +1019,16 @@ Kernel parameters
>                         seconds. A value of 0 disables the blank timer.
>                         Defaults to 0.
>
> +       core.async_shutdown=3D
> +                       [KNL]
> +                       Format: <bool>
> +                       Enable or disable asynchronous shutdown support. =
When
> +                       enabled, on system shutdown unrelated devices fla=
gged
> +                       as async shutdown compatible may be shut down in
> +                       parallel and asynchronously. When disabled, devic=
e
> +                       shutdown is performed in a serially and synchrono=
usly.
> +                       Enabled by default.
> +
>         coredump_filter=3D
>                         [KNL] Change the default value for
>                         /proc/<pid>/coredump_filter.
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index a5b7abc10ff0..40dbf588a5d6 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -103,6 +103,7 @@ struct driver_private {
>   *                        dev_err_probe() for later retrieval via debugf=
s
>   * @device: pointer back to the struct device that this structure is
>   *         associated with.
> + * @complete: completion for device shutdown ordering
>   * @dead: This device is currently either in the process of or has been
>   *       removed from the system. Any asynchronous events scheduled for =
this
>   *       device should exit without taking any action.
> @@ -119,6 +120,7 @@ struct device_private {
>         const struct device_driver *async_driver;
>         char *deferred_probe_reason;
>         struct device *device;
> +       struct completion complete;
>         u8 dead:1;
>  };
>  #define to_device_private_parent(obj)  \
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3b3d983b1747..751fe2e13b3a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/async.h>
>  #include <linux/blkdev.h>
>  #include <linux/cleanup.h>
>  #include <linux/cpufreq.h>
> @@ -37,6 +38,10 @@
>  #include "physical_location.h"
>  #include "power/power.h"
>
> +static bool async_shutdown =3D true;
> +module_param(async_shutdown, bool, 0644);
> +MODULE_PARM_DESC(async_shutdown, "Enable asynchronous device shutdown su=
pport");
> +
>  /* Device links support. */
>  static LIST_HEAD(deferred_sync);
>  static unsigned int defer_sync_state_count =3D 1;
> @@ -3606,6 +3611,7 @@ static int device_private_init(struct device *dev)
>         klist_init(&dev->p->klist_children, klist_children_get,
>                    klist_children_put);
>         INIT_LIST_HEAD(&dev->p->deferred_probe);
> +       init_completion(&dev->p->complete);
>         return 0;
>  }
>
> @@ -3895,6 +3901,7 @@ bool kill_device(struct device *dev)
>         if (dev->p->dead)
>                 return false;
>         dev->p->dead =3D true;
> +       complete_all(&dev->p->complete);
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(kill_device);
> @@ -4865,6 +4872,37 @@ int device_change_owner(struct device *dev, kuid_t=
 kuid, kgid_t kgid)
>         return error;
>  }
>
> +static bool wants_async_shutdown(struct device *dev)
> +{
> +       return async_shutdown && dev_async_shutdown(dev);
> +}
> +
> +static int wait_for_device_shutdown(struct device *dev, void *data)
> +{
> +       bool async =3D *(bool *)data;
> +
> +       if (async || wants_async_shutdown(dev))
> +               wait_for_completion(&dev->p->complete);
> +
> +       return 0;
> +}
> +
> +static void wait_for_shutdown_dependencies(struct device *dev, bool asyn=
c)
> +{
> +       struct device_link *link;
> +       int idx;
> +
> +       device_for_each_child(dev, &async, wait_for_device_shutdown);
> +
> +       idx =3D device_links_read_lock();
> +
> +       dev_for_each_link_to_consumer(link, dev)
> +               if (!device_link_flag_is_sync_state_only(link->flags))
> +                       wait_for_device_shutdown(link->consumer, &async);
> +
> +       device_links_read_unlock(idx);
> +}
> +
>  static void __shutdown_one_device(struct device *dev)
>  {
>         if (dev->p->dead)
> @@ -4888,6 +4926,8 @@ static void __shutdown_one_device(struct device *de=
v)
>                         dev_info(dev, "shutdown\n");
>                 dev->driver->shutdown(dev);
>         }
> +
> +       complete_all(&dev->p->complete);
>  }
>
>  static void shutdown_one_device(struct device *dev)
> @@ -4917,6 +4957,80 @@ static void shutdown_one_device(struct device *dev=
)
>         put_device(dev);
>  }
>
> +static void async_shutdown_handler(void *data, async_cookie_t cookie)
> +{
> +       struct device *dev =3D data;
> +
> +       wait_for_shutdown_dependencies(dev, true);
> +       shutdown_one_device(dev);
> +}
> +
> +static bool shutdown_device_async(struct device *dev)
> +{
> +       if (async_schedule_dev_nocall(async_shutdown_handler, dev))
> +               return true;
> +
> +       dev_clear_async_shutdown(dev);
> +       return false;
> +}
> +
> +
> +static void start_async_shutdown_devices(void)
> +{
> +       struct device *dev, *next, *ndev, *needs_put =3D NULL;
> +       bool clear_async =3D false;
> +
> +       if (!async_shutdown)
> +               return;
> +
> +       spin_lock(&devices_kset->list_lock);
> +restart:
> +       list_for_each_entry_safe_reverse(dev, next, &devices_kset->list,
> +                                        kobj.entry) {
> +               if (wants_async_shutdown(dev)) {
> +                       if (clear_async) {
> +                               dev_clear_async_shutdown(dev);
> +                               continue;
> +                       }
> +                       get_device(dev);
> +
> +                       if (!list_entry_is_head(next, &devices_kset->list=
,
> +                                               kobj.entry))
> +                               ndev =3D get_device(next);
> +                       else
> +                               ndev =3D NULL;
> +                       spin_unlock(&devices_kset->list_lock);
> +
> +                       if (shutdown_device_async(dev)) {
> +                               list_del_init(&dev->kobj.entry);


Sashiko detected a locking error here. The lock rework made
list_del_init occur while not holding the spinlock, which is a
potential list corruption issue. This will be corrected in the next
iteration.

David Jeffery

