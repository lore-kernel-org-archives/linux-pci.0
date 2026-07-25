Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159602DF6F4
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784945196; cv=pass; b=O/PXKUZzlwCpLR1GF6S/XdvbuUodk/Z7/ffs9mXXComZsGo620hmkUhq4vf/S2m1pp4F0UdNOVvLxLvn5k7DqwR3pv8cIs40gfxVK0lbUP8zmqgtLTbYEroxzvt+/ir16MYjL7YXUwz6t+DkwQXpqr9ZJMJl6qhd0pH9Y0KmDbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784945196; c=relaxed/simple;
	bh=L5qGAffGmX3nspooolqiwAcC7WsEVWoR2Veo7ewGCSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsRoh/CBWuVUqZeJFUevOpJ2UILU+0t2syHDOsd6D2qYBDGr6zykrjtx9WvrfKlSomfsOp80KJbkjTzTl/cUBUrqHu+9yNqIp5Ah8wEMznP2YFJK6W4MuQmYmlZkZndbJrQjl9Rt3UV3Ojo7m9fgplgioAAqfOYGViMyW6CNipg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6S4vPuU; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6S4vPuU"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66899fe9077so1188613d50.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 19:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784945194; cv=none;
        d=google.com; s=arc-20260327;
        b=Sf7Z8Z1z3Tfw8MeyFalM0vZTYuTxN1nT/9hRkzqz3xNg7D7BFk04Hlgtw8ncO/SXlz
         HBdXB3OQVi/fH+Do9A68xEh7Gf6OLmWH8QGXGcPO2/EONq/smjlJLNuAc4QtIpC/aoGk
         MsbVVDQUJ9eW4nuX2bYA04byhsDb5XRfHiC1UCOcJDpFDG3WPs9HjPY8H5XHMkWaXWqk
         5CqQL8twzG8V70tay9GyMcdBk5RbpxtGz8POs4tldaqrpDicJZOHhIUA7SV6Lki0L+tq
         PZ/g83qrJBLRrbALaCYKwIferJfyLiNd9d8PBil7+HblClsgKg1bBlF9eUsMAjA5fKxP
         arXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YyIn45P2Tgd+kwRH0bCnOAMTzFmDbZvrPVqTzQ76aus=;
        fh=ixUbBB5AM+u72pEpNZOhPjgnxhhHTu5S4gCFnsjaLWY=;
        b=moCkX0o4USEO5w3vj1M6Lwz3TMlxyoV7LC4HNDWKdfamdSmxipr4eZfe6rTsAfnko4
         sa9gUzooP6FGAbQdDs+A0fhnPALzX6kF7yZ8YdAafZGcrLecxRz75gUU6qt2jjK+9mXd
         4GPwfwB2P+3e16rCRZPv4U7ouYJZPTFf9ezWs7SKKS0dJsVlAxa0zY3tBC4GNB0hXEBL
         OpSdiiKfCE5yOuo6YBp7j0FI+T4rqSHdXbaBlFzx9c+ja3r/vMInW4HAaDCbmqDaPZ1h
         K7Mmf4c8gYSNCP4/e/GWBan1+C+JoY1xbqRVwPp6T9KmRwD24pmSFNsG0SoNJBHm1f27
         1yFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784945194; x=1785549994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YyIn45P2Tgd+kwRH0bCnOAMTzFmDbZvrPVqTzQ76aus=;
        b=G6S4vPuUbq3hcFLKxyKLcoWgYLxYXL80mnMOFBmbgegrji4niRbZssxqIyG0z6gtae
         DJq1pT3CPLS7Rhcihw8ursz2ef1Ty2Oxa1sFsyNi6cUq6T6CRF3Aji8wiICIJGkchkWo
         ebsM47qf17XGxkr5PR3eoHX7wG7Blrw2SrYaLVYFd4Iz6vGThI95q55/4ZMSe0kbBmcU
         MdwiaW71F3gQ1uEn31MKeXK3rhrs9vUEx7dyZQP9XhDwdaCCARYFv+vKv6ky0JK5AJ26
         bMm7f1OPoybz/R+J7qu3fyl9Yz+5LlZRGTPY4Vv3iYI8qJHzU9XKZwxq7jG3+9DqnLqz
         O+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784945194; x=1785549994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyIn45P2Tgd+kwRH0bCnOAMTzFmDbZvrPVqTzQ76aus=;
        b=Y4OAqtpEOUnCvLyrZcMIWN7J5B/szVEZHwa9i6xWZQSMeDM6KIR7OltshpB/3N6vvF
         TdCWQygg9CA8RzfNasvyssgZ2XxleTINIQWuHZEz0+uukQCf5GImINY9EI9UfYltt6xG
         1IygQy8R3dd0/oZb/XHWheN04NOtxB5Iy6633qbz7PHpwZhWV2tItkJHSOo0j5jYwJmS
         iVzQDgrgZ4db9Fb/MuTX7D4etWJKAtmu/6wnxcw8FCrxSko8h3TP73CdyMnkuWolV1/G
         ckpzTAQ02QH6F8lIUvy1akqjjiIgSBwcgtPsDwHVZkNjfybsGYrJkb4wN7TQiIGaFVib
         t4dg==
X-Forwarded-Encrypted: i=1; AHgh+RqZuHO0Pb5ZaDrjiE8oRj6a5F+LXl2M71NFjhd9SH6/vPRz6VGV1zdBZp0BXLHhzGP+1L9z+UApRsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOKYnT9rX85Qivx7lm5MqAvB6XkEQntLv1CZrRa2h5PoVhRMwd
	qGeCsMY23JHvwE9DNtuhkaHegGkmE2QKeomQrWkungG+QG8MePU9ygEJqQtAgWzjuuQYrevPSJa
	WFRUavNKwmvBb6iPV939n+m/bv/Wr1bQ=
X-Gm-Gg: AR+sD12qrSLJb/HXcCLX3BFFiTeCYQSkTrkqA31b0JKeVMdclz4KsCCMp5FnZUmh7Lj
	92fHbPkTNcXGHvzEyQAIqlChPRJLUBHOhuqoAA40Bd9CthRkixN8YOsk7Vydg6oDCuMLIbmucol
	IC64uRwhq0C1UpuCestGDfI8kpCyX551Up6XdsHMwF1TM929cJ27A9N3xo0ajYbfoZb+6bAb5JV
	b2OavbnTTpw7nMjQgnm2V4TaXwUlkJS6qO+CMsK+cquCWP4Xh1ZrMWlK5SjikjycKc2SeJBkWTx
	t49FJS893RT64fAg2IZJUewQ//7Rem68hEJL0rv9vAfJkSGhz6PPxHRWWyVAt86UGllBhtV0SYr
	xwgUEFqLPOgJdcuE9pvT4cnK0Z+x9Bfp1Is10CrrMAaBNsw==
X-Received: by 2002:a05:690c:6184:b0:814:3d8f:7ae3 with SMTP id
 00721157ae682-81f69e398damr2832257b3.39.1784945193815; Fri, 24 Jul 2026
 19:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADhLXY6F5G-prnD=c+oKYPvOhXTukjs3_1TksEvjPU6u+u+6og@mail.gmail.com>
 <20260622171926.GA684276@bhelgaas>
In-Reply-To: <20260622171926.GA684276@bhelgaas>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 25 Jul 2026 07:36:22 +0530
X-Gm-Features: AUfX_mzqpEt_9agwz8Kk91HWH8Pjw24-JS1hudYtter30lqHxUY0Gx62lBWgv8E
Message-ID: <CADhLXY7zDB+88YLUqsvJ_k0j-CPYf3=JyHWightcKCD97jz_+g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/proc: check user access return values in proc_bus_pci_{read,write}()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:49=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Sun, Jun 21, 2026 at 01:52:17PM +0530, Deepanshu Kartikey wrote:
> > On Mon, May 4, 2026 at 7:52=E2=80=AFAM Deepanshu Kartikey <kartikey406@=
gmail.com> wrote:
> > >
> > > proc_bus_pci_write() ignores the return value of __get_user(). On a
> > > faulting user pointer the extable fixup zeros the destination, and th=
e
> > > function writes those zeros to PCI configuration space.
> > >
> > > syzbot triggers this with writev()-ing a NULL iov_base to
> > > /proc/bus/pci/00/03.0 (the virtio-blk controller in the syzkaller VM)=
:
> > > zero is written to the Command register, clearing Bus Master Enable,
> > > and the disk stops responding. In-flight journal writes never complet=
e
> > > and jbd2 hangs in wait_on_buffer() indefinitely:
> > >
> > >   INFO: task jbd2/sda1-8 blocked in I/O wait for more than 143 second=
s.
> > >    __wait_on_buffer fs/buffer.c:123
> > >    jbd2_journal_commit_transaction+0x388a/0x6870 fs/jbd2/commit.c:837
> > >    kjournald2 fs/jbd2/journal.c:201
> > >
> > > proc_bus_pci_read() has the symmetric problem with __put_user(): a
> > > faulting user pointer silently drops config-space data and returns
> > > success.
> > >
> > > Switch both functions to get_user()/put_user(), which combine the
> > > access_ok() check with the load/store and return -EFAULT on failure.
> > > The up-front access_ok() can be removed accordingly. On error, jump t=
o
> > > a common label that releases the runtime-PM reference and returns
> > > -EFAULT.
> > >
> > > Reported-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dc7604c9fdd7580cca4e=
0
> > > Tested-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
> > > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > > ---
> > > Changes in v2:
> > >  - Use get_user()/put_user() and drop access_ok() (Krzysztof)
> > >  - Rename label to err: per kernel convention (Krzysztof)
> > >  - Simplify error path to release runtime-PM and return -EFAULT (Krzy=
sztof)
> > >  - Apply the same fix to proc_bus_pci_read() (Krzysztof)
> > > ---
> > >  drivers/pci/proc.c | 44 ++++++++++++++++++++++++++++----------------
> > >  1 file changed, 28 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> > > index ce36e35681e8..8e624d829840 100644
> > > --- a/drivers/pci/proc.c
> > > +++ b/drivers/pci/proc.c
> > > @@ -53,15 +53,13 @@ static ssize_t proc_bus_pci_read(struct file *fil=
e, char __user *buf,
> > >                 nbytes =3D size - pos;
> > >         cnt =3D nbytes;
> > >
> > > -       if (!access_ok(buf, cnt))
> > > -               return -EINVAL;
> > > -
> > >         pci_config_pm_runtime_get(dev);
> > >
> > >         if ((pos & 1) && cnt) {
> > >                 unsigned char val;
> > >                 pci_user_read_config_byte(dev, pos, &val);
> > > -               __put_user(val, buf);
> > > +               if (put_user(val, buf))
> > > +                       goto err;
> > >                 buf++;
> > >                 pos++;
> > >                 cnt--;
> > > @@ -70,7 +68,8 @@ static ssize_t proc_bus_pci_read(struct file *file,=
 char __user *buf,
> > >         if ((pos & 3) && cnt > 2) {
> > >                 unsigned short val;
> > >                 pci_user_read_config_word(dev, pos, &val);
> > > -               __put_user(cpu_to_le16(val), (__le16 __user *) buf);
> > > +               if (put_user(cpu_to_le16(val), (__le16 __user *) buf)=
)
> > > +                       goto err;
> > >                 buf +=3D 2;
> > >                 pos +=3D 2;
> > >                 cnt -=3D 2;
> > > @@ -79,7 +78,8 @@ static ssize_t proc_bus_pci_read(struct file *file,=
 char __user *buf,
> > >         while (cnt >=3D 4) {
> > >                 unsigned int val;
> > >                 pci_user_read_config_dword(dev, pos, &val);
> > > -               __put_user(cpu_to_le32(val), (__le32 __user *) buf);
> > > +               if (put_user(cpu_to_le32(val), (__le32 __user *) buf)=
)
> > > +                       goto err;
> > >                 buf +=3D 4;
> > >                 pos +=3D 4;
> > >                 cnt -=3D 4;
> > > @@ -89,7 +89,8 @@ static ssize_t proc_bus_pci_read(struct file *file,=
 char __user *buf,
> > >         if (cnt >=3D 2) {
> > >                 unsigned short val;
> > >                 pci_user_read_config_word(dev, pos, &val);
> > > -               __put_user(cpu_to_le16(val), (__le16 __user *) buf);
> > > +               if (put_user(cpu_to_le16(val), (__le16 __user *) buf)=
)
> > > +                       goto err;
> > >                 buf +=3D 2;
> > >                 pos +=3D 2;
> > >                 cnt -=3D 2;
> > > @@ -98,7 +99,8 @@ static ssize_t proc_bus_pci_read(struct file *file,=
 char __user *buf,
> > >         if (cnt) {
> > >                 unsigned char val;
> > >                 pci_user_read_config_byte(dev, pos, &val);
> > > -               __put_user(val, buf);
> > > +               if (put_user(val, buf))
> > > +                       goto err;
> > >                 pos++;
> > >         }
> > >
> > > @@ -106,6 +108,10 @@ static ssize_t proc_bus_pci_read(struct file *fi=
le, char __user *buf,
> > >
> > >         *ppos =3D pos;
> > >         return nbytes;
> > > +
> > > +err:
> > > +       pci_config_pm_runtime_put(dev);
> > > +       return -EFAULT;
> > >  }
> > >
> > >  static ssize_t proc_bus_pci_write(struct file *file, const char __us=
er *buf,
> > > @@ -129,14 +135,12 @@ static ssize_t proc_bus_pci_write(struct file *=
file, const char __user *buf,
> > >                 nbytes =3D size - pos;
> > >         cnt =3D nbytes;
> > >
> > > -       if (!access_ok(buf, cnt))
> > > -               return -EINVAL;
> > > -
> > >         pci_config_pm_runtime_get(dev);
> > >
> > >         if ((pos & 1) && cnt) {
> > >                 unsigned char val;
> > > -               __get_user(val, buf);
> > > +               if (get_user(val, buf))
> > > +                       goto err;
> > >                 pci_user_write_config_byte(dev, pos, val);
> > >                 buf++;
> > >                 pos++;
> > > @@ -145,7 +149,8 @@ static ssize_t proc_bus_pci_write(struct file *fi=
le, const char __user *buf,
> > >
> > >         if ((pos & 3) && cnt > 2) {
> > >                 __le16 val;
> > > -               __get_user(val, (__le16 __user *) buf);
> > > +               if (get_user(val, (__le16 __user *) buf))
> > > +                       goto err;
> > >                 pci_user_write_config_word(dev, pos, le16_to_cpu(val)=
);
> > >                 buf +=3D 2;
> > >                 pos +=3D 2;
> > > @@ -154,7 +159,8 @@ static ssize_t proc_bus_pci_write(struct file *fi=
le, const char __user *buf,
> > >
> > >         while (cnt >=3D 4) {
> > >                 __le32 val;
> > > -               __get_user(val, (__le32 __user *) buf);
> > > +               if (get_user(val, (__le32 __user *) buf))
> > > +                       goto err;
> > >                 pci_user_write_config_dword(dev, pos, le32_to_cpu(val=
));
> > >                 buf +=3D 4;
> > >                 pos +=3D 4;
> > > @@ -163,7 +169,8 @@ static ssize_t proc_bus_pci_write(struct file *fi=
le, const char __user *buf,
> > >
> > >         if (cnt >=3D 2) {
> > >                 __le16 val;
> > > -               __get_user(val, (__le16 __user *) buf);
> > > +               if (get_user(val, (__le16 __user *) buf))
> > > +                       goto err;
> > >                 pci_user_write_config_word(dev, pos, le16_to_cpu(val)=
);
> > >                 buf +=3D 2;
> > >                 pos +=3D 2;
> > > @@ -172,7 +179,8 @@ static ssize_t proc_bus_pci_write(struct file *fi=
le, const char __user *buf,
> > >
> > >         if (cnt) {
> > >                 unsigned char val;
> > > -               __get_user(val, buf);
> > > +               if (get_user(val, buf))
> > > +                       goto err;
> > >                 pci_user_write_config_byte(dev, pos, val);
> > >                 pos++;
> > >         }
> > > @@ -182,6 +190,10 @@ static ssize_t proc_bus_pci_write(struct file *f=
ile, const char __user *buf,
> > >         *ppos =3D pos;
> > >         i_size_write(ino, dev->cfg_size);
> > >         return nbytes;
> > > +
> > > +err:
> > > +       pci_config_pm_runtime_put(dev);
> > > +       return -EFAULT;
> > >  }
> > >
> > >  #ifdef HAVE_PCI_MMAP
> > > --
> > > 2.43.0
> > >
> >
> > Gentle Reminder on this patch. Please let me know the status of this
> > patch.
>
> Thanks for the reminder.  We're halfway through the merge window for
> v7.2, so we'll have to look at this for v7.3 after v7.2-rc1 is tagged.

Hi Bjorn,

Any update on this patch ?

Thanks

Deepanshu
