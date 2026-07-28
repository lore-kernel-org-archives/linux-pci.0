Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAAA4756AE;
	Tue, 28 Jul 2026 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275820; cv=none; b=IiwN+rfkZ5NMR+mZAazodL6iJrWiKragVHMO7VegfHB5oTXDqjHUywUtbHuTP+xbx4j8d45Hlss5MV/8m6voJZeS00oq9MVEScYaIdWOTvROkSR25AaXHqVQV9KPre9n7lni8bFMBygUBLcM6ElsI7WgffVwnAEAE17NyX+1LiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275820; c=relaxed/simple;
	bh=cdy0g/nKdxty366qImqvpcAmcZhy+zBh0Z2t6QEgwRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ixr1N8VQNKTvUbVUBum/JjskjAbIkjmc9k39xYGsKx+SXLd1+Syjk5ipSroXyi2ovG1smR8eybtmF05YF/haueUupoVnuEzyEF00jVdD3koS9w8NqLPsGcNhQD/oEdS0bBPYJ2jk1rsppt0ZyT8ed8KC9VfHw70A2bNDIxsvUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt2HWEaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt2HWEaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF661F000E9;
	Tue, 28 Jul 2026 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785275808;
	bh=D/kVLOj+hFIJeBH6n2ip5Hjahw38qkedPguWVx0z17o=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Qt2HWEaCu0Jw/iwYyCkRcmuRQvZHh94V9HvLCQ+lT53xGJypy+bQGSot985RZ5JjD
	 8zFG3nGVHf5je3qu4zjqtgWkdx7PRpLCNY+Wsk435TpmfU/HCY1yY1Aw30Nft7yg/C
	 Mu4pJngQbpsVXzRp5HOpXtmReUlKOMeXl1Cb4KO4IsSF0NbJj7jz3ftH+p1JrCoJXP
	 JAy7d8VSbckvXqRqBFQclEMZc0YJWJ/WeH2SI+Og9m0fw9MByGIFNtMsyntkMNLSpt
	 WdXao1biO4+cNfFx6HVVqT5JwwhJotIJ3Wo5Wb8HyJvO3Mhizpxvwb+If9yxLBMkI9
	 TtCQuhWZVZo1A==
Date: Tue, 28 Jul 2026 16:56:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] PCI/proc: check user access return values in
 proc_bus_pci_{read,write}()
Message-ID: <20260728215647.GA1402909@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504022231.15501-1-kartikey406@gmail.com>

On Mon, May 04, 2026 at 07:52:31AM +0530, Deepanshu Kartikey wrote:
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
> Closes: https://syzkaller.appspot.com/bug?extid=c7604c9fdd7580cca4e0
> Tested-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Thanks for this patch!

I asked gemini to reduce the syzbot repro details and focus on the
issues of writing bogus data to config space, returning success with
invalid read data, and returning -EFAULT.  It suggested the log below;
what do you think?

  PCI/proc: Return -EFAULT on get_user() and put_user() failures

  proc_bus_pci_write() ignores the return value of __get_user(). On a
  faulting user-space pointer, the exception table fixup zeros the
  destination, and proc_bus_pci_write() writes those invalid zeros
  into PCI configuration space.

  proc_bus_pci_read() ignores the return value of __put_user(). On a
  faulting user-space pointer, it fails to copy the PCI configuration
  space data to user space but still returns success.

  Fix both issues by:

    - Switching to get_user() and put_user() and checking return values

    - Returning -EFAULT, not -EINVAL, when get_user() or put_user() fails

    - Removing the redundant access_ok() checks, since get_user() and
      put_user() validate access internally

> ---
> Changes in v2:
>  - Use get_user()/put_user() and drop access_ok() (Krzysztof)
>  - Rename label to err: per kernel convention (Krzysztof)
>  - Simplify error path to release runtime-PM and return -EFAULT (Krzysztof)
>  - Apply the same fix to proc_bus_pci_read() (Krzysztof)
> ---
>  drivers/pci/proc.c | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index ce36e35681e8..8e624d829840 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -53,15 +53,13 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  		nbytes = size - pos;
>  	cnt = nbytes;
>  
> -	if (!access_ok(buf, cnt))
> -		return -EINVAL;
> -
>  	pci_config_pm_runtime_get(dev);
>  
>  	if ((pos & 1) && cnt) {
>  		unsigned char val;
>  		pci_user_read_config_byte(dev, pos, &val);
> -		__put_user(val, buf);
> +		if (put_user(val, buf))
> +			goto err;
>  		buf++;
>  		pos++;
>  		cnt--;
> @@ -70,7 +68,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  	if ((pos & 3) && cnt > 2) {
>  		unsigned short val;
>  		pci_user_read_config_word(dev, pos, &val);
> -		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
> +		if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
> +			goto err;
>  		buf += 2;
>  		pos += 2;
>  		cnt -= 2;
> @@ -79,7 +78,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  	while (cnt >= 4) {
>  		unsigned int val;
>  		pci_user_read_config_dword(dev, pos, &val);
> -		__put_user(cpu_to_le32(val), (__le32 __user *) buf);
> +		if (put_user(cpu_to_le32(val), (__le32 __user *) buf))
> +			goto err;
>  		buf += 4;
>  		pos += 4;
>  		cnt -= 4;
> @@ -89,7 +89,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  	if (cnt >= 2) {
>  		unsigned short val;
>  		pci_user_read_config_word(dev, pos, &val);
> -		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
> +		if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
> +			goto err;
>  		buf += 2;
>  		pos += 2;
>  		cnt -= 2;
> @@ -98,7 +99,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  	if (cnt) {
>  		unsigned char val;
>  		pci_user_read_config_byte(dev, pos, &val);
> -		__put_user(val, buf);
> +		if (put_user(val, buf))
> +			goto err;
>  		pos++;
>  	}
>  
> @@ -106,6 +108,10 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  
>  	*ppos = pos;
>  	return nbytes;
> +
> +err:
> +	pci_config_pm_runtime_put(dev);
> +	return -EFAULT;
>  }
>  
>  static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
> @@ -129,14 +135,12 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  		nbytes = size - pos;
>  	cnt = nbytes;
>  
> -	if (!access_ok(buf, cnt))
> -		return -EINVAL;
> -
>  	pci_config_pm_runtime_get(dev);
>  
>  	if ((pos & 1) && cnt) {
>  		unsigned char val;
> -		__get_user(val, buf);
> +		if (get_user(val, buf))
> +			goto err;
>  		pci_user_write_config_byte(dev, pos, val);
>  		buf++;
>  		pos++;
> @@ -145,7 +149,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  
>  	if ((pos & 3) && cnt > 2) {
>  		__le16 val;
> -		__get_user(val, (__le16 __user *) buf);
> +		if (get_user(val, (__le16 __user *) buf))
> +			goto err;
>  		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
>  		buf += 2;
>  		pos += 2;
> @@ -154,7 +159,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  
>  	while (cnt >= 4) {
>  		__le32 val;
> -		__get_user(val, (__le32 __user *) buf);
> +		if (get_user(val, (__le32 __user *) buf))
> +			goto err;
>  		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
>  		buf += 4;
>  		pos += 4;
> @@ -163,7 +169,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  
>  	if (cnt >= 2) {
>  		__le16 val;
> -		__get_user(val, (__le16 __user *) buf);
> +		if (get_user(val, (__le16 __user *) buf))
> +			goto err;
>  		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
>  		buf += 2;
>  		pos += 2;
> @@ -172,7 +179,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  
>  	if (cnt) {
>  		unsigned char val;
> -		__get_user(val, buf);
> +		if (get_user(val, buf))
> +			goto err;
>  		pci_user_write_config_byte(dev, pos, val);
>  		pos++;
>  	}
> @@ -182,6 +190,10 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  	*ppos = pos;
>  	i_size_write(ino, dev->cfg_size);
>  	return nbytes;
> +
> +err:
> +	pci_config_pm_runtime_put(dev);
> +	return -EFAULT;
>  }
>  
>  #ifdef HAVE_PCI_MMAP
> -- 
> 2.43.0
> 
