Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F883B6BF4
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263852; cv=none; b=OtzSI4wAL6sAv108DFy1zCkYpM820gZahNKSYf0f4x+9QUuc8TfzbSk4fVUE7BpcdKp5nqgv6PNDjnAn+zdMaxhIT89MR8/u5PDp6LplZc5ibEC1eEHWQOAiZKAeblSM5xSYNqx0mphCRiCCJ7ZjuEtNIrd9FaNvByUAypRR/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263852; c=relaxed/simple;
	bh=Zv0yR6BbcReSaHov0VqNC9B/8SSZfpbix7YMNfapxko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qje0z56Ek7gRzv2fW2lx49ru7FmORIuOKf4QPUkW7ArDN32EuTmd+EHoe6Q0KnA/y8pLbhea6eclh14vFMwkzWCE3rbj7chmZ8RbU3aXnDPKGno/XLOr4cUOwOHMbWWnEekCq/VlqGvsmzjceP6SsHySg7vZuV4v6KKpQTTFPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=T0wPbh7d; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="T0wPbh7d"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab22370so1930100d50.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1790263849; x=1790868649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDrpvpL5sqLAVvdAjrAo2ss1QyRZ0bD4iQxldapowE0=;
        b=T0wPbh7d/Bx9PC95dGTd6rBz3qyg9tLmExyFAHpN7n0iC8qLrdvvYxYzVgb7hH5Dmb
         gRo12ueIRaB78jY7HuDbDrXHEqRvC2jkn4Ft2h1TvDFb/BLcEIQj9ply63Eniv+sYl2f
         FuyekpbwnRtg+7P7RG8SkTSZ7TaIkczgptk2GCcqVDEFmAU7qOjv6zJgOByjZzbuQQO1
         qi6YZaMEaAAPuz7xVtQ1PJwvNSyWHm2uuHbj2nbULcp5nys3PD64PPCaiyFSM5gttSOf
         p0eDaV99i4QpVED0C2CG04yNBdbfEAOK8KX2gFYnlNjgdLbeMVphvxpZwFPL148zfYWE
         Hjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263849; x=1790868649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iDrpvpL5sqLAVvdAjrAo2ss1QyRZ0bD4iQxldapowE0=;
        b=pySLDYKi5OzmztTCfrla/rUdQkesycdfdux34cISBQLRnGlDqgV4NK1WIUFcgIZIe9
         rdqPNac+sU0yqk1TFexB6HRG/ewjsqdAit7RT3BMzXGckfwb5NKq2NFmJzgOqDlf/fBj
         GUetOT/LvRK2zEtLa9SH8qz10xWd/YcJ/kEzfsXTCYXws8CFXvnBX5p7CFwd0FPwxREc
         IemgIQEk8FGWCDFPa3hIQJ+uqUkoLtZ0vl0S80CVnwqsx1pVGMpYOeJOdmI3nb8XvchU
         1yl/xuQSb+Q/g9sIZv0eZtGrRWiCZfR6+iqPuw1nJNG7jc92Yu9gcaETbIpYeyYTq5Tr
         CO6w==
X-Forwarded-Encrypted: i=1; AKwUvBzA6EKBJI+uJSGePfCkwQHYeddpMa2LQCsPybkOHR4rSld/3m6BHV+2/594C7XoUMxiN7JYu9xR5YM=@vger.kernel.org
X-Gm-Message-State: AFuF++lEXEY8zG+AoK4D1loqSncv7e+gBrXWacV73l4KF3/5rwAmBJ7z
	gYEynKTofJo4AtHWIdXMGSHQt62Sx+Pv95axqKha2z4IOcSqphKDieAMDd3CVnp8tg==
X-Gm-Gg: AYBFou36gWOG9jh1Yc3f+/tUtatTFENzd7wjo5hWOJ+MYcGnBy8APjg9dRUOb0XL3kd
	GME7Hr99StI5JHKmLbu/q2VrCDcE2JFoVixril/z4i2zxU14a9+dF/6Ed84/ljpyzUJB9e4zwMj
	GiqFbyWAA3QFpQyJZenaL0LNdAMmIQiVLQ+PFhRQSTY6hiWz0fqYrVSh8PNpvjZPt2I4A40CR0B
	AusECH2v2h63IXYnMBtkf1QQC4Sxm6AsNZGJxp8ly8IvuTmip3A6aLntyP/yuLzhpSByqCKPrcZ
	yaZrUkAS2lryPiMQN+tXYJm6JAZlnnOdjfpXXEVF1lsi/pYEOjv7hoE/JeYjWgYEmGy3o9cyBzW
	ren4OiXKuJX6l6uqKREiAJ3WqgszczqN3limh1qoUH38LgIF4xO3zSp+9+7d0cuwSsMygNpJN9N
	H54jTCa7Yrdzq2ol/cxE8Hb94U61VBpSvfb9OZvV9LfsXsqMF5BtN9sPeGVh0s8sBcDyPSHUlFq
	Y1jLkdOIp+hGuT2NYtPnUxOjg8Y1xtDz/cORJcVbro=
X-Received: by 2002:a05:690e:1188:b0:672:cf59:f2f9 with SMTP id 956f58d0204a3-672ed4db4f2mr1353663d50.101.1790263849097;
        Thu, 24 Sep 2026 08:30:49 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e21792bsm18821596d6.11.2026.09.24.08.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:30:48 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:30:46 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Francisco =?iso-8859-1?Q?Beltr=E1n_Millal=E9n?= <fbeltranmillalen@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] usb: hcd-pci: Honour pci_save_state() failure
Message-ID: <cbd8331c-5049-4521-bba1-b57a892e4269@rowland.harvard.edu>
References: <20260924124221.12374-1-fbeltranmillalen@gmail.com>
 <20260924124221.12374-2-fbeltranmillalen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924124221.12374-2-fbeltranmillalen@gmail.com>

On Thu, Sep 24, 2026 at 09:42:18AM -0300, Francisco Beltrán Millalén wrote:
> hcd_pci_suspend_noirq() calls pci_save_state() and ignores its return
> value, then goes on to call pci_prepare_to_sleep().  pci_save_state()
> can fail -- it already propagates failures from pci_save_pcie_state()
> and friends -- and when it does there is no saved state to restore
> later, so putting the device into a low-power state only makes matters
> worse: the subsequent transition fails too, and the PCI core then warns
> that the callback returned without saving the state.
> 
> Check the return value.  If the state could not be saved, leave the
> device alone and return success, so the rest of the system can still
> suspend.  Leaving the power state untouched also means the PCI core has
> nothing to complain about.
> 
> Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -541,7 +541,17 @@
>  	if (retval)
>  		return retval;
>  
> -	pci_save_state(pci_dev);
> +	/*
> +	 * If the controller is already inaccessible, there is no state to
> +	 * save and nothing to put into a low-power state.  Leaving the power
> +	 * state alone also keeps the PCI core from warning that this callback
> +	 * returned without saving the state.
> +	 */
> +	retval = pci_save_state(pci_dev);
> +	if (retval) {
> +		dev_dbg(dev, "--> not suspending, device inaccessible\n");
> +		return 0;
> +	}
>  
>  	/* If the root hub is dead rather than suspended, disallow remote
>  	 * wakeup.  usb_hc_died() should ensure that both hosts are marked as
> 
