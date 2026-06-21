Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC561A6836
	for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782030152; cv=pass; b=VUGeNg2z/eiqI3ExebHAN8YYV/zfVxOAiFVlydseKbegBbJ/VJJM0PT/ZQcpxR12B2ivfoyWc/UNCukKgDPNRkBpNQlZYPyaxumZqpXOeS0gPzXtbg8a8hu9SM3GfFnW1eVMLMdsioeX3T233x2BcqRdg66wYOhTQQOQ7ahCask=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782030152; c=relaxed/simple;
	bh=gKIWmx5zWV5LsCWOjY1X7ahn/14a30AzR+mW7BXPR8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3DL4k7ZxGecX66ILmLsA8n01UoeMnC1yvZiQuJH8YopQjS3fzCBqOFkjYca2gI2J8VwFXjLapi6v5pXACuGXaNYfXLIoPQohQvSQIYoesmBJJdytA3QSyP0RZNAEwdy+I394jZ1gy4BGqy4Kft7Y/7PP4MCLDjvHBhUPsa1gBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G21MJJPX; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G21MJJPX"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66043ecf6b3so3071719d50.0
        for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 01:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782030149; cv=none;
        d=google.com; s=arc-20240605;
        b=LVxktWEjeuTROkqYuurseUkf4a9PSwDAmNhfF3OX/CoqIexq8uu0CVH0WFmlX2xw1E
         v+44K/xbzShaSDG7KFZ3hH4RNebQxF96SUKv/IYkFe6DcRYSMrB3O4VluHAkoUCdpcbP
         jgn/DAxkTFz7IFVyhTlVFtX/kO64CYV5QX8egBWq6i5xtozhBv0julZMZICa1RSzZxWA
         JptZeeh9qCKWRP/XMWkU1IfViHfwdXc8KuM1zSvNjn5yZLTDXXNlv4ZI00AUzWncxXWc
         1jJz9si0VRe6vfboBPmMPFqs76brg2dHonXi3crcQ5ldMx3CS8RG/iX2V99mgMTT9fUg
         JTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n/EmXSHaoeoh2XOA2NeyT+wN02eAbXCj4e0t7spo2Es=;
        fh=Jr2XzqYh+D/54zt4e9q2AoWQ7MG81obCfYhvN2C5/GA=;
        b=SLlDF6W17fL7iGIKh0fvEVT7VS/VGxvBM5no399SEwmAFDkR/eF72lv9DrdxjbDM3N
         h3BgDlQFR2ChSR3sGEE/s1bF5RVwD1Mhtm88F/xrn2jA8WzMQrCD/PirX5Mc8OTbp1qm
         VCq9Jma3LfByVTyH7JhnfCGSMDLmyHjuFfun5lYGiUezYt9nIUAZ6XjNxuMTLEHdhEi4
         QOV5cfFcYtwvHj6AehTlxgekwopGkGzBUb9h16frO/HEUviXBSMu4YqBQeMGA6uy60J1
         UTKDHZdvl3DHnbjriZRteg1bcqGzmoDTcL11aVBECX/YKQRgH9SJ/SounCEcX7Dp6GSE
         TsMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782030149; x=1782634949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/EmXSHaoeoh2XOA2NeyT+wN02eAbXCj4e0t7spo2Es=;
        b=G21MJJPXnWNQ9RwSAZqC/sCJQj4A/GmhUsrsUB3LnW8ar3+USKlZ52N7FQZIV78nJd
         1FtDZknwSXjNTjxxbMnIuDis8tVUk9KiIc1bKAFbnLWHavOkmcQsVJbCMeoyqYEv+fsy
         lDzUcxB5zauDYpATkNAOfEDB6ITl2COcLcOmDjbKv67xBst9hO4TrV5+BcDBXqVZJ23a
         8SGShMeLjX/6eiaJ9RV3illfXJ4/JTJRcMa+uir/ql0hUepnbzFM5Sg2YJ3ki7ySh8ly
         3wKYD6PXmBWXx4csWXKPC3dNQnSBqL4R3Yw/qAbVada4HuqoGhTqvtnDdIRGzmnWDlQC
         uCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782030149; x=1782634949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/EmXSHaoeoh2XOA2NeyT+wN02eAbXCj4e0t7spo2Es=;
        b=RpbzUmThTj7unbJj3b1uPZf206T994lMlkMhfhCspM/bFeaMjCe9tX//FcVF9WbO4s
         ekSeeQAthYoPyz/fJO3OJ8mWEQU39puGg3L7Uu5zsm6YxrzWLu2Tuh1huncCKMrI21g4
         878W7QyA720cSoqEMej6+x7GuDQe/VENJtAw7wpzp8gjyxcSTSJwOWNjCWe/nl7e+6oW
         VihdLMbacnpFMmY44feRhC/QH2dvnONRgnBUzAfCFEfhwNcEwCgll2c1PpQp4ZKRL1zH
         a6gu8/S23tA/2YogGTZcnOEgfk8Sl/GhO/EtCKJuj90Dz+x5bItOfGqg7N6fCUanpTVd
         4ImQ==
X-Gm-Message-State: AOJu0YxO38SviFFLqRwnORrgTp+PIJ0tDDNTAoInHn6gnz0sI8EqNnRD
	qOia6Dy0Hlgr09jdSVMEUPlekW2xke1DW/Hg7WxbrwgbOsHTFJcFf1zDHgn9KHoWDg6KVabETUf
	BP3LCqWJvNBhz+WFc6FENmwXcmFpZ+Ao=
X-Gm-Gg: AfdE7cmqnc1RF4yGPKSF5tL6y2Nwya096l6IwuLdFgOBup+gJLoDZfcOZPIgR3h4HPd
	6zK2/1jjIddCF3W2psQOwLp/NxpwIeH3Xg0s6Yjc8lBznE1tbwDp26iFjTM8d/cp4oqNKjVnTzu
	RyInw8PHdee5SBQV+zaEGbjA6Sd0F/3qJwswpJfjMw49wNxorZ/qK9SxssxQ33O0MfBBJXdEqR4
	GWE0T83WZNy9/6CG29RUsG9nSEY7m33JZXddp9Yk/n+YEn7HCDZvTaegQHAjUgQRebme5GE6sXq
	D7ezRrOPFUZhbc8+h7NkEqpKZ4U8cPIvmBBnDCkmcPKVcQK1GyiNHSpw8J5E/w==
X-Received: by 2002:a05:690e:11c2:b0:65e:4bcb:2a7d with SMTP id
 956f58d0204a3-663033e1518mr7446064d50.57.1782030148982; Sun, 21 Jun 2026
 01:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504022231.15501-1-kartikey406@gmail.com>
In-Reply-To: <20260504022231.15501-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 21 Jun 2026 13:52:17 +0530
X-Gm-Features: AVVi8Cfrh5vcb8HIszaI5eodCyWZ0B5MmcdY-OjNWtJkmJQyR9CDm5MgkTsOQCw
Message-ID: <CADhLXY6F5G-prnD=c+oKYPvOhXTukjs3_1TksEvjPU6u+u+6og@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/proc: check user access return values in proc_bus_pci_{read,write}()
To: bhelgaas@google.com, kw@linux.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 7:52=E2=80=AFAM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> proc_bus_pci_write() ignores the return value of __get_user(). On a
> faulting user pointer the extable fixup zeros the destination, and the
> function writes those zeros to PCI configuration space.
>
> syzbot triggers this with writev()-ing a NULL iov_base to
> /proc/bus/pci/00/03.0 (the virtio-blk controller in the syzkaller VM):
> zero is written to the Command register, clearing Bus Master Enable,
> and the disk stops responding. In-flight journal writes never complete
> and jbd2 hangs in wait_on_buffer() indefinitely:
>
>   INFO: task jbd2/sda1-8 blocked in I/O wait for more than 143 seconds.
>    __wait_on_buffer fs/buffer.c:123
>    jbd2_journal_commit_transaction+0x388a/0x6870 fs/jbd2/commit.c:837
>    kjournald2 fs/jbd2/journal.c:201
>
> proc_bus_pci_read() has the symmetric problem with __put_user(): a
> faulting user pointer silently drops config-space data and returns
> success.
>
> Switch both functions to get_user()/put_user(), which combine the
> access_ok() check with the load/store and return -EFAULT on failure.
> The up-front access_ok() can be removed accordingly. On error, jump to
> a common label that releases the runtime-PM reference and returns
> -EFAULT.
>
> Reported-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc7604c9fdd7580cca4e0
> Tested-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v2:
>  - Use get_user()/put_user() and drop access_ok() (Krzysztof)
>  - Rename label to err: per kernel convention (Krzysztof)
>  - Simplify error path to release runtime-PM and return -EFAULT (Krzyszto=
f)
>  - Apply the same fix to proc_bus_pci_read() (Krzysztof)
> ---
>  drivers/pci/proc.c | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index ce36e35681e8..8e624d829840 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -53,15 +53,13 @@ static ssize_t proc_bus_pci_read(struct file *file, c=
har __user *buf,
>                 nbytes =3D size - pos;
>         cnt =3D nbytes;
>
> -       if (!access_ok(buf, cnt))
> -               return -EINVAL;
> -
>         pci_config_pm_runtime_get(dev);
>
>         if ((pos & 1) && cnt) {
>                 unsigned char val;
>                 pci_user_read_config_byte(dev, pos, &val);
> -               __put_user(val, buf);
> +               if (put_user(val, buf))
> +                       goto err;
>                 buf++;
>                 pos++;
>                 cnt--;
> @@ -70,7 +68,8 @@ static ssize_t proc_bus_pci_read(struct file *file, cha=
r __user *buf,
>         if ((pos & 3) && cnt > 2) {
>                 unsigned short val;
>                 pci_user_read_config_word(dev, pos, &val);
> -               __put_user(cpu_to_le16(val), (__le16 __user *) buf);
> +               if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
> +                       goto err;
>                 buf +=3D 2;
>                 pos +=3D 2;
>                 cnt -=3D 2;
> @@ -79,7 +78,8 @@ static ssize_t proc_bus_pci_read(struct file *file, cha=
r __user *buf,
>         while (cnt >=3D 4) {
>                 unsigned int val;
>                 pci_user_read_config_dword(dev, pos, &val);
> -               __put_user(cpu_to_le32(val), (__le32 __user *) buf);
> +               if (put_user(cpu_to_le32(val), (__le32 __user *) buf))
> +                       goto err;
>                 buf +=3D 4;
>                 pos +=3D 4;
>                 cnt -=3D 4;
> @@ -89,7 +89,8 @@ static ssize_t proc_bus_pci_read(struct file *file, cha=
r __user *buf,
>         if (cnt >=3D 2) {
>                 unsigned short val;
>                 pci_user_read_config_word(dev, pos, &val);
> -               __put_user(cpu_to_le16(val), (__le16 __user *) buf);
> +               if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
> +                       goto err;
>                 buf +=3D 2;
>                 pos +=3D 2;
>                 cnt -=3D 2;
> @@ -98,7 +99,8 @@ static ssize_t proc_bus_pci_read(struct file *file, cha=
r __user *buf,
>         if (cnt) {
>                 unsigned char val;
>                 pci_user_read_config_byte(dev, pos, &val);
> -               __put_user(val, buf);
> +               if (put_user(val, buf))
> +                       goto err;
>                 pos++;
>         }
>
> @@ -106,6 +108,10 @@ static ssize_t proc_bus_pci_read(struct file *file, =
char __user *buf,
>
>         *ppos =3D pos;
>         return nbytes;
> +
> +err:
> +       pci_config_pm_runtime_put(dev);
> +       return -EFAULT;
>  }
>
>  static ssize_t proc_bus_pci_write(struct file *file, const char __user *=
buf,
> @@ -129,14 +135,12 @@ static ssize_t proc_bus_pci_write(struct file *file=
, const char __user *buf,
>                 nbytes =3D size - pos;
>         cnt =3D nbytes;
>
> -       if (!access_ok(buf, cnt))
> -               return -EINVAL;
> -
>         pci_config_pm_runtime_get(dev);
>
>         if ((pos & 1) && cnt) {
>                 unsigned char val;
> -               __get_user(val, buf);
> +               if (get_user(val, buf))
> +                       goto err;
>                 pci_user_write_config_byte(dev, pos, val);
>                 buf++;
>                 pos++;
> @@ -145,7 +149,8 @@ static ssize_t proc_bus_pci_write(struct file *file, =
const char __user *buf,
>
>         if ((pos & 3) && cnt > 2) {
>                 __le16 val;
> -               __get_user(val, (__le16 __user *) buf);
> +               if (get_user(val, (__le16 __user *) buf))
> +                       goto err;
>                 pci_user_write_config_word(dev, pos, le16_to_cpu(val));
>                 buf +=3D 2;
>                 pos +=3D 2;
> @@ -154,7 +159,8 @@ static ssize_t proc_bus_pci_write(struct file *file, =
const char __user *buf,
>
>         while (cnt >=3D 4) {
>                 __le32 val;
> -               __get_user(val, (__le32 __user *) buf);
> +               if (get_user(val, (__le32 __user *) buf))
> +                       goto err;
>                 pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
>                 buf +=3D 4;
>                 pos +=3D 4;
> @@ -163,7 +169,8 @@ static ssize_t proc_bus_pci_write(struct file *file, =
const char __user *buf,
>
>         if (cnt >=3D 2) {
>                 __le16 val;
> -               __get_user(val, (__le16 __user *) buf);
> +               if (get_user(val, (__le16 __user *) buf))
> +                       goto err;
>                 pci_user_write_config_word(dev, pos, le16_to_cpu(val));
>                 buf +=3D 2;
>                 pos +=3D 2;
> @@ -172,7 +179,8 @@ static ssize_t proc_bus_pci_write(struct file *file, =
const char __user *buf,
>
>         if (cnt) {
>                 unsigned char val;
> -               __get_user(val, buf);
> +               if (get_user(val, buf))
> +                       goto err;
>                 pci_user_write_config_byte(dev, pos, val);
>                 pos++;
>         }
> @@ -182,6 +190,10 @@ static ssize_t proc_bus_pci_write(struct file *file,=
 const char __user *buf,
>         *ppos =3D pos;
>         i_size_write(ino, dev->cfg_size);
>         return nbytes;
> +
> +err:
> +       pci_config_pm_runtime_put(dev);
> +       return -EFAULT;
>  }
>
>  #ifdef HAVE_PCI_MMAP
> --
> 2.43.0
>

Gentle Reminder on this patch. Please let me know the status of this patch.

Thanks

Deepanshu Kartikey
