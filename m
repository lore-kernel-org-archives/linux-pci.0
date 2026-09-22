Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828F549373
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094875; cv=pass; b=DI5iqnIalHbQB3hWA3hyWeNu1ggadVkAjUl02qN2WzPH3vpJapRB0BmK3V7WGU/f2iG3Fu0qcfdtTz84kNBRv/ttTkMyjb0fW7P0saaLi74jGsl8hNgoFjojNBti6zs5ibs8BZN1gZvY9BX4gU/bVfQUaoomsjPK9dvfiKhQCAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094875; c=relaxed/simple;
	bh=cKbRWUWUNFCMJjKOH3yHgRtEpoahj/lRVoNkkOfXTsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XntiBYBH9Xa/8KL8kswZzkS5pTuExIvGBvVYUyaCxzOb88kRopBdMaHUyOhBrxevFK+1UhY1qfUTmWWZze0YFRSmH0n34UBPnegGGZ6muY4IOm52ykSkwqn1piKS/2L+W4eBysxGQOHHqFZ1UEX65dAgh6Gyqx9Ur8WolxdJE7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AB0zXoy1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFcMYyPe; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AB0zXoy1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFcMYyPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790094872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKbRWUWUNFCMJjKOH3yHgRtEpoahj/lRVoNkkOfXTsg=;
	b=AB0zXoy1Yvcm012ebd22g93OJbpurDQn8u1uHe5d8RzsT3ZMpvCxh+yo0EUJqXz7bfpG5G
	PKjxa7qRnG1F6zZ1ph085yF6pgjNLW2brVmm5iZ6VKBRiBZG/P9YOQ0hCC7epr0C7KjsEH
	+G6OYZB0KHfZrCFF7neyM9Bu0OgJUss=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-u-YmouGwOPGhpMpnzmXtrw-1; Tue, 22 Sep 2026 12:34:31 -0400
X-MC-Unique: u-YmouGwOPGhpMpnzmXtrw-1
X-Mimecast-MFC-AGG-ID: u-YmouGwOPGhpMpnzmXtrw_1790094871
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c82ad4977dso22587e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 09:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790094871; cv=none;
        d=google.com; s=arc-20260327;
        b=lUMe0NIZaITttoUXYIHvvvEyUUIaHrw0P6bWkdPtj2vQOUA/DoQNTjIWspSSmMqELr
         Qjq84YTEWakmVbrara4Ih9Si7aqUGbgXUehV4NuPtR+6d6xBTTtd04rxSVwwJMjQEDmm
         ahZgHq0mcP2MVPfjp4UHUjwtW/nywYbZK4GyuyhQRel1gp/3VAVSUwx5mSSRxxfxqfMQ
         eOH4mH4RJGo9U9LtBJObnfeEuiLtSJGnXRm+w6pxGti+vblpBYh0lMeNzsZ8n72YRtRG
         qLI0BqtKJwoUhK3uHZVxu7q+VlyKGBkvVIbSasuUuYEEQJTq7SUR/g+NtcHrnXOk1M23
         s3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cKbRWUWUNFCMJjKOH3yHgRtEpoahj/lRVoNkkOfXTsg=;
        fh=32PPT12dF7pZqT39e7yw3hpmvStHpM6kTYcxBqmdOnY=;
        b=mEq+1AYbS81jRwttcmScDQth20GuDL3eWTbAkikD9F/Ko5h08fj50jYm6nOXERItui
         6W4A10Kuw7hVkw6xOfx4HJmq+YuIMpUO2NWSEnA2sPJtY134LJ2pUU9eDcQroE+ZCTyF
         wJYijCY6eZeeKiT0tAKY4NV/t4jDLkth1gdc+phEBbGhkQBwqtkSm4h3DJMDzRdux1+z
         4n1u32V0cGzjqXEW5A+jBUWTNKTiei9nCSmj9vjj6uceFefhysu0zcjBkxe9k2Ha6okM
         E+BId+u4WjLpT5CKjhlKwbeY7DndzVyvKLfbwbOVvcDNroo2OeAp0dhPTFI1JpuqFYo8
         QP0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790094871; x=1790699671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cKbRWUWUNFCMJjKOH3yHgRtEpoahj/lRVoNkkOfXTsg=;
        b=JFcMYyPeetOC3hyTIz7DST7NcJm/TD2yslUQK+hCqUdwvXUmtVKbN0d+zpIZeZgn8Y
         jXJI+fN2UNvqdUyxVn82tW+X7LeTaGQk2lMEzdOb/qnOt/P/zs8ekhAR709/DXu2pqbI
         tmypp0UV46TG+3QOXq02/QrBB0TCpP3ijZ4kuNt+t4Ky2k0V9/AO1KOX2ny4Hh+LpU7w
         8LVC9qZOG2XvIbt0hv2hPKHhDP3p3gU3eu7iSzsdHwJZmgol+OPguRIknGmsvd6tKN/I
         Mm1dFUaIxmYowaQ7hFLa0F6kZAVKr1BxRqBUSMFHRbARJJb9sZCozHRdRNvxpJP83tJM
         5jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094871; x=1790699671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cKbRWUWUNFCMJjKOH3yHgRtEpoahj/lRVoNkkOfXTsg=;
        b=FYyMnBdIeQwcbqYgueSIxWKkcmHLdOxog1y7gXWC60ub2On0tmy+3tyv2VTt6DI91Y
         01TTr7p2pdEbrlKeXjaLSuBwwm9exDlJl5o2+Hx7Wt9/ocZSRXpIxCwKkj4fxnMgfHvo
         f6hEhlXqr/S83dVI7zsUr5O41sc0Dq1BJCzVxsxklCb/NK8Q7+6tY1JfTyprtUg3MKDH
         ZbOvIimUnogJVucDBsduYSx/lHHFcIR5R3Q5TYNnMgwqQ17l5m8i7HNJSgUD1qWBFgJ5
         EdW9VZcMQ6l93wXOoWZTOeLSWZt203g6vCcJ0j0yLPNxomgdiKncoYYYjRZNsCQbGeOq
         EDVw==
X-Forwarded-Encrypted: i=1; AKwUvBx78k5xfOQ9JLteRBu9czFl5HWHVVTFZB+9Nbu+LbRSTmShDRUwx/zQjx0HRPVFxMT6Zq6usC+iO6c=@vger.kernel.org
X-Gm-Message-State: AFuF++kcGTljv647/0Fh8E10dkbHbUI/+bQcTC716vFacyOGl+BmuNpf
	GeU9cccTFijnnYE678bPNKgOe62qGYb1kb5Q16BIuN4fajz0AotjVttbIrVIubJChMNV1rq4l3A
	Hzb1yx3MUGUzcxTSu5KGL2+edLGvIw/Uh+i6jBcGv3SGtTjJSU+mogP8VnVnv00JATXDfFMsrSh
	Utm0TszzrkFa8lRFrq4A0PL1gzMvWaF/rGatLE
X-Gm-Gg: AYBFou1WtLTL+P1+uh70JUlCA2DK6UAqjN5xFAe9vVjQaCZbPIZTqrHp7aCh3uRikk2
	0B6lFaxZsSO4rwlwNELIDuieCifgQSd3WhJcO8/5DfPv5rH9NShuzE/3ZeTu6y3xAA3/07KpLUp
	FXEFiR5dp+k/tEpQwtr0tKc/qtoDOzzINeEy2pe2qv0j/wt+t+GslPNTXKG/ha9B4GSlbfsGma+
	FLhzACc7kSQg38Oww8hAtTPZXu05EMP8i2/58BZ7dUVBu+m5eKRYa1207fcJUUHYnoAADTNmVc=
X-Received: by 2002:a05:6122:4d01:b0:5c2:b01f:e503 with SMTP id 71dfb90a1353d-5c9f15bb2a3mr57773e0c.7.1790094870700;
        Tue, 22 Sep 2026 09:34:30 -0700 (PDT)
X-Received: by 2002:a05:6122:4d01:b0:5c2:b01f:e503 with SMTP id
 71dfb90a1353d-5c9f15bb2a3mr57708e0c.7.1790094870278; Tue, 22 Sep 2026
 09:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917163744.191748-1-djeffery@redhat.com>
In-Reply-To: <20260917163744.191748-1-djeffery@redhat.com>
From: David Jeffery <djeffery@redhat.com>
Date: Tue, 22 Sep 2026 12:34:19 -0400
X-Gm-Features: AclHuK_gOIIAGH-J9mfA_6kGZQPoZd_UXxbRIgUMsQf82GPy6D8kJfhp32jIMog
Message-ID: <CA+-xHTE65H=WSU4kavq7dC=FkaMVKuEZiNw5-o5DekRpgRkDeA@mail.gmail.com>
Subject: Re: [PATCH v22 0/9] shut down devices asynchronously
To: driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, kexec@lists.infradead.org, 
	Ewan Milne <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>, 
	"Lombardi, Maurizio" <mlombard@redhat.com>, Bart Van Assche <bvanassche@acm.org>, 
	John Garry <john.g.garry@oracle.com>, Jeremy Allison <jallison@ciq.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Pasha Tatashin <tatashin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 12:37=E2=80=AFPM David Jeffery <djeffery@redhat.com=
> wrote:
>
> These patches are rebased against the driver-core tree's driver-core-next
> branch and should also apply against recent linux-next. Changes for v18 a=
re
> contained in patch 3.
>
> This patchset allows the kernel to shutdown devices asynchronously and
> unrelated async devices to be shut down in parallel to each other.
>
> Only devices which explicitly enable it are shut down asynchronously. The
> default is for a device to be shut down from the synchronous shutdown loo=
p.
>
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minute=
s
> without this patch to 55 seconds with the patch. And on another system fr=
om
> 80 seconds to 11.
>
> And thank you to everyone who has spent some of their valuable time
> providing reviews, suggestions, criticisms, or tests on the various
> iterations of this patchset.
>
> Changes from V21:
> - Check a device is alive before accessing its bus pointer
>

And this has resolved Sashiko's last complaint. Sashiko found no
issues with the v22 patchset.

David Jeffery

