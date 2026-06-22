Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FAD126BF7;
	Mon, 22 Jun 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148769; cv=none; b=MjAprJv3cBMZ/h6X8MiIGPsDWYWgGONuXTLDL/87YdDVpHaVObKERlAGAH89xuzw2PHRC2m3/86WbDg5sV7MMVyZN4E7e7uHJvw3X3BoAdFu3D6p33NgWaYFMCBmQAOpm8lxByDs7M7Wz/LvuLdDeY67pIDY8us2jL6C8ha3jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148769; c=relaxed/simple;
	bh=tInr4TBaU4MuA49RED8w5Lk/KBSzygWhk6z0Kus2o1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=No2gtJAfd3vN5b1ehQinoyethYcVluJ1s4lfsskCJPCRqQy3OCR+5IUfw3oHYxGeYx15UKIo+/O+8yMDab0tRW5PVMCfa6XzqSgfB71mqDExz/2W2xxriBX8MSqjbXy9Ir4f9DZ1yGGnBfwxj/e6R7vu1FmnXsF4wdVGdcJS09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfjTl+l+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfjTl+l+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02671F000E9;
	Mon, 22 Jun 2026 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148768;
	bh=4e9haZm8PHCtW0GWvaD9CRzSoYpXU2mtDGKOneISMEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HfjTl+l+wp2cJ8Snlpc+RMW8EpQBOdg1abBiQ+XV8IFhkPdALF7sqZ3BcTgDgUe9P
	 Vod35zb8PbMj2mVDOdGAkUYEObnCde5t24jaWwGESmBL6pXtlkSz8Ri3TcR8JYnf/k
	 j1Hc+2ndX/WXGTjquNAGyutBPDKPRTYUWgC/mBfKreaALunOuMuDtJEOU565XcnNDc
	 kpDBEGhqHJzHfolvcUnYrbg6vQ/ub+EIPrmevaYV0I4ciKoQCIvOzUerzjaE0Y8s9p
	 0GWXElf9lnIUezey/fmciIlt2LHKXhRW+ZPl52g02Gqr2vpyz0nBFGS/sVDLnf+KYH
	 EJUl4xcVaMZZg==
Date: Mon, 22 Jun 2026 12:19:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] PCI/proc: check user access return values in
 proc_bus_pci_{read,write}()
Message-ID: <20260622171926.GA684276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhLXY6F5G-prnD=c+oKYPvOhXTukjs3_1TksEvjPU6u+u+6og@mail.gmail.com>

On Sun, Jun 21, 2026 at 01:52:17PM +0530, Deepanshu Kartikey wrote:
> On Mon, May 4, 2026 at 7:52 AM Deepanshu Kartikey <kartikey406@gmail.com> wrote:
> >
> > proc_bus_pci_write() ignores the return value of __get_user(). On a
> > faulting user pointer the extable fixup zeros the destination, and the
> > function writes those zeros to PCI configuration space.
> >
> > syzbot triggers this with writev()-ing a NULL iov_base to
> > /proc/bus/pci/00/03.0 (the virtio-blk controller in the syzkaller VM):
> > zero is written to the Command register, clearing Bus Master Enable,
> > and the disk stops responding. In-flight journal writes never complete
> > and jbd2 hangs in wait_on_buffer() indefinitely:
> >
> >   INFO: task jbd2/sda1-8 blocked in I/O wait for more than 143 seconds.
> >    __wait_on_buffer fs/buffer.c:123
> >    jbd2_journal_commit_transaction+0x388a/0x6870 fs/jbd2/commit.c:837
> >    kjournald2 fs/jbd2/journal.c:201
> >
> > proc_bus_pci_read() has the symmetric problem with __put_user(): a
> > faulting user pointer silently drops config-space data and returns
> > success.
> >
> > Switch both functions to get_user()/put_user(), which combine the
> > access_ok() check with the load/store and return -EFAULT on failure.
> > The up-front access_ok() can be removed accordingly. On error, jump to
> > a common label that releases the runtime-PM reference and returns
> > -EFAULT.
> >
> > Reported-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c7604c9fdd7580cca4e0
> > Tested-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> > Changes in v2:
> >  - Use get_user()/put_user() and drop access_ok() (Krzysztof)
> >  - Rename label to err: per kernel convention (Krzysztof)
> >  - Simplify error path to release runtime-PM and return -EFAULT (Krzysztof)
> >  - Apply the same fix to proc_bus_pci_read() (Krzysztof)
> > ---
> >  drivers/pci/proc.c | 44 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 28 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> > index ce36e35681e8..8e624d829840 100644
> > --- a/drivers/pci/proc.c
> > +++ b/drivers/pci/proc.c
> > @@ -53,15 +53,13 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
> >                 nbytes = size - pos;
> >         cnt = nbytes;
> >
> > -       if (!access_ok(buf, cnt))
> > -               return -EINVAL;
> > -
> >         pci_config_pm_runtime_get(dev);
> >
> >         if ((pos & 1) && cnt) {
> >                 unsigned char val;
> >                 pci_user_read_config_byte(dev, pos, &val);
> > -               __put_user(val, buf);
> > +               if (put_user(val, buf))
> > +                       goto err;
> >                 buf++;
> >                 pos++;
> >                 cnt--;
> > @@ -70,7 +68,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
> >         if ((pos & 3) && cnt > 2) {
> >                 unsigned short val;
> >                 pci_user_read_config_word(dev, pos, &val);
> > -               __put_user(cpu_to_le16(val), (__le16 __user *) buf);
> > +               if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
> > +                       goto err;
> >                 buf += 2;
> >                 pos += 2;
> >                 cnt -= 2;
> > @@ -79,7 +78,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
> >         while (cnt >= 4) {
> >                 unsigned int val;
> >                 pci_user_read_config_dword(dev, pos, &val);
> > -               __put_user(cpu_to_le32(val), (__le32 __user *) buf);
> > +               if (put_user(cpu_to_le32(val), (__le32 __user *) buf))
> > +                       goto err;
> >                 buf += 4;
> >                 pos += 4;
> >                 cnt -= 4;
> > @@ -89,7 +89,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
> >         if (cnt >= 2) {
> >                 unsigned short val;
> >                 pci_user_read_config_word(dev, pos, &val);
> > -               __put_user(cpu_to_le16(val), (__le16 __user *) buf);
> > +               if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
> > +                       goto err;
> >                 buf += 2;
> >                 pos += 2;
> >                 cnt -= 2;
> > @@ -98,7 +99,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
> >         if (cnt) {
> >                 unsigned char val;
> >                 pci_user_read_config_byte(dev, pos, &val);
> > -               __put_user(val, buf);
> > +               if (put_user(val, buf))
> > +                       goto err;
> >                 pos++;
> >         }
> >
> > @@ -106,6 +108,10 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
> >
> >         *ppos = pos;
> >         return nbytes;
> > +
> > +err:
> > +       pci_config_pm_runtime_put(dev);
> > +       return -EFAULT;
> >  }
> >
> >  static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
> > @@ -129,14 +135,12 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
> >                 nbytes = size - pos;
> >         cnt = nbytes;
> >
> > -       if (!access_ok(buf, cnt))
> > -               return -EINVAL;
> > -
> >         pci_config_pm_runtime_get(dev);
> >
> >         if ((pos & 1) && cnt) {
> >                 unsigned char val;
> > -               __get_user(val, buf);
> > +               if (get_user(val, buf))
> > +                       goto err;
> >                 pci_user_write_config_byte(dev, pos, val);
> >                 buf++;
> >                 pos++;
> > @@ -145,7 +149,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
> >
> >         if ((pos & 3) && cnt > 2) {
> >                 __le16 val;
> > -               __get_user(val, (__le16 __user *) buf);
> > +               if (get_user(val, (__le16 __user *) buf))
> > +                       goto err;
> >                 pci_user_write_config_word(dev, pos, le16_to_cpu(val));
> >                 buf += 2;
> >                 pos += 2;
> > @@ -154,7 +159,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
> >
> >         while (cnt >= 4) {
> >                 __le32 val;
> > -               __get_user(val, (__le32 __user *) buf);
> > +               if (get_user(val, (__le32 __user *) buf))
> > +                       goto err;
> >                 pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
> >                 buf += 4;
> >                 pos += 4;
> > @@ -163,7 +169,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
> >
> >         if (cnt >= 2) {
> >                 __le16 val;
> > -               __get_user(val, (__le16 __user *) buf);
> > +               if (get_user(val, (__le16 __user *) buf))
> > +                       goto err;
> >                 pci_user_write_config_word(dev, pos, le16_to_cpu(val));
> >                 buf += 2;
> >                 pos += 2;
> > @@ -172,7 +179,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
> >
> >         if (cnt) {
> >                 unsigned char val;
> > -               __get_user(val, buf);
> > +               if (get_user(val, buf))
> > +                       goto err;
> >                 pci_user_write_config_byte(dev, pos, val);
> >                 pos++;
> >         }
> > @@ -182,6 +190,10 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
> >         *ppos = pos;
> >         i_size_write(ino, dev->cfg_size);
> >         return nbytes;
> > +
> > +err:
> > +       pci_config_pm_runtime_put(dev);
> > +       return -EFAULT;
> >  }
> >
> >  #ifdef HAVE_PCI_MMAP
> > --
> > 2.43.0
> >
> 
> Gentle Reminder on this patch. Please let me know the status of this
> patch.

Thanks for the reminder.  We're halfway through the merge window for
v7.2, so we'll have to look at this for v7.3 after v7.2-rc1 is tagged.
