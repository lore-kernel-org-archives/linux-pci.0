Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BF3C7692
	for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925255; cv=none; b=YNS1JL/Vuzj/JTRAlQpJqJLTEVlvn6u5orSsFsFDDSh48KtzWHQWatDZYpY6uS2Gj3ts23FIVN8z7oQ3Q0YfhyYjOGk4uQ6LbaQMoXHvfdEoFwaYlA5T8Ndfdrrxp5tYPNLZtZXK5ROeRNaAG5cyqXWIcPCiDk7Xu+jmjZVOSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925255; c=relaxed/simple;
	bh=1Xy4NCOAjBGdPmJvcRedWnSw8+ESyA1QrdqTyB89WTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSImtQt0+JpzS4aEwvkiSYkSXV+PrtzxfHwSuTLW5npJJFjErumW+m5ib00ubE7yEibbxdw9rrcl3r9bmhTtzjQd7BlYvjmVVpCgNiz72jlfZDt3dTs+7Ain8dhdRs/nR0TNkPq48MQRhSJkSKEXVPi2AhHvFu1CrrxGM4Jn1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgJjaQGL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgJjaQGL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso16218085e9.0
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789925252; x=1790530052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gv728gDCR5y3/MpdGoG7nq1FaK3marGJjkydLjHBb1k=;
        b=hgJjaQGL2VIO/f+HEVAky9yc7IAEMWozNceohD9NdprHODs5dMAFA29lpXbiNly1cV
         1yvHG0vWU/ibCxTVj50IVG1GJ+XrRklgoyQcXmL7jARMRR76PEBkMe1afwgSRxjKxOQw
         B930fxN/yeByttx6ulHGC15J1AdneeacMxTkOLYcOj563M5cuFkBf+yFv61/XgEyIArk
         Y4jTIAJ+mCQkErOGckBXHQyFbhWB+Z6nd6ZANnB1T91j03eVpLiKJvby3PMgLQzGTb/5
         T2oaWgdxEI8GtTFzkyrFb81nGQwKNNCA2J5Y6UdfJTJpvUx+hiYWoy1ZbSFEwVRKnsmT
         ZrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789925252; x=1790530052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gv728gDCR5y3/MpdGoG7nq1FaK3marGJjkydLjHBb1k=;
        b=UCbGkheKtQdfhRdkmoTt6/m8AVpWThGOR+n7eb4N2KJvy+vkmpJOToa6e8+czVbQoR
         zZAu32Fr+kDXxFw1WgJkpRU8XGy5HEoJZyOnPMH84SLS3uPYM2303U0mZxuFWECqYlb+
         sVRv75RAYWJbcDUDw5yQOpFTFts03jtJJNRUbT8Ocn69cGJrChZUBtwxUao+ULmxwd1j
         05u5OCE5JK9dTGLgE5JMtLyCX4SKQ9VsRr7usaDpPjxlZkekyAe7nUIcttRRRgyhfU5N
         Vg8kWfLpacE6cHErRj9RHN1Gh9QgnTR9Z522M9CH1oZnZYAtAKXxejQEz1W79nhsWdHB
         QUrg==
X-Forwarded-Encrypted: i=1; AKwUvBzpv4sW0qzKKJO3MnAa9kJkiuHV9ib5REGOq4yaa8s7B66P0UngVqnDk1r7laurrD+GVm+8dKERNm0=@vger.kernel.org
X-Gm-Message-State: AFuF++kkwKGVWZQM0DzM1CckUGUUiEjauHfrwpMWAhgqPAdVlYW7cT8s
	5p7ozLy7x3JWeb+h1mYRltpzBV+pURpjq2eDvRbLiO/ISpnnx+iTwpPS
X-Gm-Gg: AYBFou1dE52t9a9krP840yR7p2Wm8MKswaNhtblp18i+Pa4HUsQOG+G2SAurPMqumkx
	MLVP8s88jmiPTSQG+e3s7GxpWDBLnFzUS720h9VT2yO2nLGsdoGfH/SEDySRN2FdyK5A1BA1VG3
	rIVDrTG5WWVrglusRaolDr1w3t0P9QPP28eYHtZS+TOqWfa0TnauaUD+UPjFSupkF0+Cj5THqeo
	TaC2hwX1o4ELqkZPlLzTYWOpJnX4J9Adrb1ZE8LUFkxaho704beSRb0mZ0VxSazvC6hXvB2oGu4
	4D/tyw8+LrMY5QiN5Fg0DZRMaDCShojPVXQnhum/7k4093i61kkdgqm5uJ4ewbIHTxr6Lz09Xyt
	u9Vu4VmAgROgvUPzjSvGA221TyGBFpEm1lZeZgNx0c3BzkmmKE1SPETh9g5HQfmI3V8Cbadso7F
	jFSt41aGyuYI+5qLGbGtOye1qp4Y1eaKzS2u64DPi6oW7urBcpjOUrHACj1ARSYz3SHbzQC9z/J
	Msx7itUdN3UfgoPA4cLaWUT+t0L2VUxLEn++9rnNJexr8/xqxDZ3w==
X-Received: by 2002:a05:600c:6095:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49fc566e558mr124071075e9.1.1789925252214;
        Sun, 20 Sep 2026 10:27:32 -0700 (PDT)
Received: from home-desktop (dynamic-002-214-012-189.2.214.pool.telefonica.de. [2.214.12.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd103325sm192189215e9.9.2026.09.20.10.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:27:31 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:27:29 +0200
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	kees@kernel.org, xueshuai@linux.alibaba.com
Subject: Re: [PATCH RFC 2/3] PCI: pciehp: Report surprise removal from
 pciehp_isr()
Message-ID: <arAXgbTgz3YINvxn@home-desktop>
References: <20260905183905.997833-1-abhinjoses@gmail.com>
 <20260905183905.997833-3-abhinjoses@gmail.com>
 <20260912115420-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912115420-mutt-send-email-mst@kernel.org>

On Sat, Sep 12, 2026 at 11:57:38AM -0400, Michael S. Tsirkin wrote:
> On Sat, Sep 05, 2026 at 06:38:59PM +0000, Abhin Parekadan Jose wrote:
> >  
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 23b1605e783a..4e17878edeab 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -805,6 +805,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> >  	pci_doe_disconnected(dev);
> >  
> > +	return 0;
> > +}
> > +
> > +static inline int schedule_notification_work(struct pci_dev *dev, void *unused)
> > +{
> > +	pci_dev_set_disconnected(dev, NULL);
> 
> 
> Does this not break what patch 1 was trying to do,
> for everyone who does not call schedule_notification_work,
> that is, everyone except pciehp?
> 
> I'd say do the reverse: make schedule_notification_work
> schedule the work, and have both pcieh and 
> pci_dev_set_disconnected call that.
> 

Thanks for the review.

Yes - I've already done that locally. It'll be in the next version.

I've also been working through the races Sashiko flagged and looking for
other race conditions.

One is left: pciehp_is_spurious_link_change() ends up consuming the
one-shot flags PCI_DPC_RECOVERED and PCI_LINK_CHANGED, so whichever of
pciehp_ist() and pciehp_disconnect_work() calls it first consumes the
flag. I have a crude fix but it's untested; I'll get to it next weekend.

> 
> >  	if (READ_ONCE(dev->disconnect_work_enable)) {
> >  		/* Make sure work is up to date. */
> >  		smp_rmb();
> > -- 
> > 2.51.1
> > 
> 
