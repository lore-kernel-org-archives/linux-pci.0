Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBAC1624DF;
	Sat, 27 Jun 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566190; cv=none; b=XXYGx+UClRkKquFF1Zr87MoLDBCRdae91UEiPyIqRt4puhsxyiYYZzQysBXoXO/lq0QXc5r8WxD6PC6qXIi52A5FSZS0sdTNXMPgAPJU7Ek2y3uZpJe+5IzEEZyMbotAYVboJxlUtlWBIAsjfLzqtrStwVYvZ4SQshOTr++WAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566190; c=relaxed/simple;
	bh=9ugpCXLDaK8Te9rukKFSo/2XalEGCJxs34dW9Sg2pJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+IDOtwpf9778TAXQdydwzEOIB80W5UeufUX62CHkcYPTmrGqrxtBuv2ug78557QuE+i6Cqd6oMkWwUHCLae5qH81jf3ghdZyExElNRQjd0gP/ltunjSCwAAcm5WlPj9ef7WjVNpz8TY+e9fh7lf3U9V31qzC3O9j8rqWnsCg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8HZ+uBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8HZ+uBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573111F000E9;
	Sat, 27 Jun 2026 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782566189;
	bh=+YPIpuI91OFw+H2QpjbfSENT5BpHc90A6VDnusXJQm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e8HZ+uBFdbaMQsM6lzBmxvI9c6kfg9uwUEFWi8Tgj5WIcUTaAsSta0ooXtlGMXAV1
	 wDIrTO7Rd3CGuXrcVb+XYGuEAZfprdQvwdZ2pqNGAIUKu965F7IFyBZea6A1Hzn+Rh
	 NhjOCdds+KQxRHQmKQAg5wbcSIQmq6sTEinqo6PWK4kaCcGa1eriOMBtb2WXk5U9gH
	 ZvrMCL2EpF/6sLpT0vsSZze0vyjBZUn0fUyFsFM00Fk222/vZBGr6Ji4Bpyd/dx5I8
	 oYdDVSk/QFweys/hY8VBUlviXqDaWPZUgV/CwCDJZcCUe8hrHxToJFjMGUrZtqpegK
	 hT2tnVgQiW7lg==
Date: Sat, 27 Jun 2026 18:46:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: kwilczynski@kernel.org, kishon@kernel.org, Frank.Li@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: fix use-after-free after
 device unbind
Message-ID: <frzv3d476pvvtpi74zlc7otqxonxpq7kavohvjnunkkphjtkkp@ewyix6luqadd>
References: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
 <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622165249.374155-1-shuangpeng.kernel@gmail.com>

On Mon, Jun 22, 2026 at 12:52:49PM -0400, Shuangpeng Bai wrote:

[...]

> @@ -1141,10 +1171,15 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  {
>  	int ret = -EINVAL;
>  	enum pci_barno bar;
> -	struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
> -	struct pci_dev *pdev = test->pdev;
> +	struct pci_endpoint_test *test = file->private_data;

Can't you still use to_endpoint_test()?

> +	struct pci_dev *pdev;
>  
>  	mutex_lock(&test->mutex);
> +	pdev = test->pdev;
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto ret;
> +	}
>  
>  	reinit_completion(&test->irq_raised);
>  	test->last_irq = -ENODATA;
> @@ -1206,9 +1241,30 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  	return ret;
>  }
>  
> +static int pci_endpoint_test_open(struct inode *inode, struct file *file)
> +{
> +	struct miscdevice *miscdev = file->private_data;
> +	struct pci_endpoint_test *test = to_endpoint_test(miscdev);
> +
> +	kref_get(&test->kref);
> +	file->private_data = test;

Same as above. This is not needed.

Rest LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
