Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6892AD2C
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700755; cv=none; b=cr/tkYs34MVx6ySFp/QisVChxHlzYFZ8D1Xh4LjQDHZKK7Zvl1oQrzBpknLw+HtDXLOh4+TIMlruAsfUPMkr25uvZUvWpJ3yRAXlIAKI68cv/IGM3erXojGlSv8/l1n+5xD9kIuLo1or6PJPu+R4ZCMH3JWasZJOJJAGnAp/FOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700755; c=relaxed/simple;
	bh=bVmcjVFnoslYz/63bfIQRLQo71Xii62siraZW/407Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlUb0dZk9sFIEt7PPhtGxIRFipA2+xNc+6MtNJ79p3vu/eWP3orVIM9lOhvlpMLa8jlM0lG/Md21EmpFJ5NXdwNIdyVUQKjio/HsU097kr3m4tQNo+zwpNTU5FLlkkAkLlrylOq44zyi815nt449rxo6p3LrEYQ2MI0ia8oS4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RVo8jG4t; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RVo8jG4t"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8947e6ffd20so73750126d6.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2026 21:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770700753; x=1771305553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fuvU6Zz5R9gZa9j619e/7zPOTeoTrF2jAVNlPjsXQqQ=;
        b=RVo8jG4ttvm3wGX9fGRfL1qND8wJDvtWR73LOpuQqKuzH3/NRBAQwBY5Lqp4mlkJ7i
         AwQ0IwpnTiGV+s36pNln5X/tn5e7lPiJAEzIz6JbXlD9k+RIY+9By8I/t+t5BxZ5eNe+
         aCKqgbNXf8hHZLEqkHOQn+siKcw5QhZHo0B33JNCbj+hQw2t32t+Kx1nPxsHETFqv8PN
         Yv3qdLm5a7ch9O1vRv3vKdGJeWxazd7Fe+xsC/9BHjkzRNhV+Bg3DRrqRvD//kZaW+sV
         /K59JynrQJBc9UeZKgkxSdqArRh7wmfhtds3RAzq9/eWnSEZWyoQw3cEH21ozVA6Mwk3
         3ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770700753; x=1771305553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuvU6Zz5R9gZa9j619e/7zPOTeoTrF2jAVNlPjsXQqQ=;
        b=aJxjPBHm7wkpIYu4hz3cYXjF6yGlGYDeN71EHzNKM7C8djsSwlBE0b9QOhtUj+Z6de
         C52+Wi/38ENDGrrbA8Lawh/bm5C6rz64wBZFT3YWNa7iLiXilmQyPto8zcACSbcm7VcR
         Kkb3nKM6JkksX6JzBOl9sDBx3zMbdlkUmjBd/siMTqtM2Y0q9Rw5wxS0p9fxy1x0iXdz
         H+TZW4GpYyDZxywaxzq3cjaAfZaQMcoFaeRG7hOrFbIiPzoc1F45mwFXaaKIMW9k6c7r
         //uFFTFb3+PPu5SjvHxsEOy5+Qh0XUyta+YlxTngw8LDgfs5D2mQ2lJcFV26UkwP6VqS
         eb9w==
X-Forwarded-Encrypted: i=1; AJvYcCVFsx1hmyilAHQV9LdHxpO98iGrWWKpligTYXBeUZfWnXJc4fw3zcKXZ/7Z0+hTgpDDjlUddhaGeO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFxGP+VYeh2UIFubkufv4tnB7WK9hj7yO0WminwXJzitEzqXE
	VUHWbKqciJN+GyNEtUgqAwpKBp02KoG0yZn6tAtGyEwKyBDk6blgACD5O3scEJnhvKs=
X-Gm-Gg: AZuq6aJA3fVgcrfOqCzreIM9lpTbwlaQamQ7wcuGXsSt+GegLyOCjsbYuB0QCSF/qeb
	p0Ih61kDRkC+Na9AF36ppk/jc/dVh/sL/fb9+wyNgU4BeQxiFJYc+1BGC5gmNRRM10cTN3YgmaS
	MpTJfQsp8Pia1FipN87+PwQoh4FnJNl6hZrcLIL3n3riFApNcd4XVagc1560VOQQtClfumq2Cyk
	RQs7aVfDHdHJFw42FiHe6bd9TdLmzDHFMNuqhS13hszbKHPesmouXDUMxMq4A4cM0ByC+cUeL5E
	RfnxfNVrPlIBIrFScTyJA4Xfo+jz3yJcSs9qOSTIrjzKpo0sjPqdLiX8jHH7n97Ll1BX4SCJyGl
	aTlyICpj9QoflQaO8f2ZP3i1FYs/ardZ7OikOQ45WlzNfNj4VHbx4QEa2PcNlrTttWioyJTNYak
	+i7Bf+uqOgspwQwU/QfNZK3MxRqVZ6hk36vQCFZ9qfJ4hSMQ+eA0ozh+MdS/eghivM9QNeK0sND
	aTQpozfyhUb6B4ozo0O
X-Received: by 2002:a05:6214:409:b0:888:4930:4c8b with SMTP id 6a1803df08f44-8970e602f34mr12786586d6.69.1770700752661;
        Mon, 09 Feb 2026 21:19:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-896ff64ad07sm36075266d6.15.2026.02.09.21.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:19:12 -0800 (PST)
Date: Tue, 10 Feb 2026 00:19:10 -0500
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.jiang@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
	terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for
 CXL-dependent operation
Message-ID: <aYq_zpNAgNgJY_P8@gourry-fedora-PF4VCD3F>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
 <20251216005616.3090129-7-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251216005616.3090129-7-dan.j.williams@intel.com>

On Mon, Dec 15, 2025 at 04:56:16PM -0800, Dan Williams wrote:
> @@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>  {
>  	int rc;
>  
> +	/*
> +	 * If @attach is provided fail if the driver is not attached upon
> +	 * return. Note that failure here could be the result of a race to
> +	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
> +	 * succeeded and then cxl_mem unbound before the lock is acquired.
> +	 */
> +	guard(device)(&cxlmd->dev);
> +	if (cxlmd->attach && !cxlmd->dev.driver) {
> +		cxl_memdev_unregister(cxlmd);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>  	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
>  				      cxlmd);
>  	if (rc)


This caused a deadlock when trying to unbind cxl_pci and bind a custom
driver. 

The followwing analysis was produced by Chris Mason's kreview scripts,
but it did resolve my deadlock, and the analysis seems pretty straight
forward. 

Although it was likely caused by a qemu quirk I was dealing with at the
same time (see the note about topology failing to enumerate).

~Gregory

---

    cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
    and then calls cxl_memdev_unregister() when the attach callback was
    provided but cxl_mem_probe() failed to bind.

    cxl_memdev_unregister() calls cdev_device_del() → device_del() →
    bus_remove_device() → device_release_driver() which also takes
    device_lock(), deadlocking the calling thread.

    This path is reached when a driver uses the @attach parameter to
    devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
    DVSEC range registers decode outside platform-defined CXL ranges,
    causing the endpoint port probe to fail).

    Fix by using scoped_guard() and breaking out of the guard scope before
    calling cxl_memdev_unregister(), so device_lock() is released first.

It suggested:
---

static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
{
        int rc;

        /*
         * If @attach is provided fail if the driver is not attached upon
         * return. Note that failure here could be the result of a race to
         * teardown the CXL port topology. I.e. cxl_mem_probe() could have
         * succeeded and then cxl_mem unbound before the lock is acquired.
         *
         * Check under device_lock but unregister outside of it:
         * cxl_memdev_unregister() calls cdev_device_del() → device_del()
         * → device_release_driver() which also takes device_lock().
         */
        scoped_guard(device, &cxlmd->dev) {
                if (cxlmd->attach && !cxlmd->dev.driver) {
                        /* Drop lock before unregister to avoid deadlock */
                        break;
                }

                rc = devm_add_action_or_reset(cxlmd->cxlds->dev,
                                              cxl_memdev_unregister, cxlmd);
                if (rc)
                        return ERR_PTR(rc);

                return cxlmd;
        }

        /* Reached only when attach failed — lock is released */
        cxl_memdev_unregister(cxlmd);
        return ERR_PTR(-ENXIO);
}

