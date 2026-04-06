Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F942257843
	for <linux-pci@vger.kernel.org>; Mon,  6 Apr 2026 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502129; cv=none; b=gw4jj7NK4F7QFnB+3yxwhEjufel6qE3wQSzZWXWxzMxBpyphUjFaKfDqcMRANup1L0mXaN+vbBLabqjZXT2X5UX315JAyjTZ51AaBO239IqklU8CSORLe9cfnBiGaD9ccXTq5MNUdhB83cr8FkM8Vu4TP2L+ZbNt3G8FNmS2tsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502129; c=relaxed/simple;
	bh=v+9KS65MHbrp/p6HVIZ/3YQz/WeqheDUGbseYa3ndMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UitAGrkrDX66jdm5OMlrIiuq9wQ7GFZKtq4n5G0JH0ZwkOW40NJkA6b330AXOJbZWgF/T8ilMBKyXJKTq35UtksabuWi6DcOBxtVL+ui/Lw2lNhNBV7t0rF48wV1Lky8Rg4CtFbkpZXPIV8c5Dc6JFMuNxP4mON679FeGdOO9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj8QmBOd; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj8QmBOd"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12776bebe9fso9734654c88.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Apr 2026 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775502127; x=1776106927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSe2oQTkbqvMIVuDSTJwJ6bnD+odJ4jguUD7R1d/gBI=;
        b=Pj8QmBOd4oXbftGbrxR5Pwu1i2RuXm5c1wVeu7hf/Dwxf32NXrIbYukukF07EGEwOa
         TebJp+tHUiqSkTJGjpJmT5Kh1duQKpkQcvV3PctibhK0pUJ2VJtapRrN2WMsdze73VMj
         VUO9FLC/dERatTGuWBppGa3GUEkqF9hUBXJtxTZF6+pxOq07dU8IGengI38FSUXOO4wr
         FozaDC913B2pkbmlaGQCUsuN84W11KvRWW+axULZZSXSPMT/3j9ythUF+7dG+JubFUfd
         6Qg8rfCavKHZb/UALLsZgy92+CrKDhtkLsEN4Pmm1ON5tb3DFZYNMLkzvdG1A2jVKD89
         b6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775502127; x=1776106927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSe2oQTkbqvMIVuDSTJwJ6bnD+odJ4jguUD7R1d/gBI=;
        b=bkI4DOdJvHA6nx2qoy1bm3HCs9bSqp719mE4xzN/bQweOe435KzBaG8IFGSoFEmfVk
         R2f1XDZbQ84PPg1laYM7NOhMIoOldby36zqLmBDh2xkexUNVkBOGI0IXQDKv7Nan2Obw
         AweyHqVGqPxWuhPXsYoiAlb6ATYILld912PM2Jgp5yaGm/WfeGiL+fFBnCMakBxaduPa
         P2XyjV14i938BdbhxeIaYkW1CrpaUJ7EgVIMK8akqY8S8EuyfV5d0cIfvdIPlPNFZSoI
         fE0VjiS+HRGWSwol+F1V+sYt62Wym0VpwH8dxq9mEF6x0zvolclEFRpRSDuBHcJ/tB6t
         Qwyw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9a8n7x6oR1Hf92JxBHzeTxSy3dxYf+JwNOnJU6xIoQw/l1VP8bx5jqfuo9cXV4t2SWuSku/7hCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwedH+JSOPLowQLe4F+QINjoc7cCidf8hSNzLGUX+kiPa3s/zP1
	TBY18uUnB29rccTkfznXJ0WgGPc27Z/3CjQ+9ezUz764hcAl1viO2+oN
X-Gm-Gg: AeBDievUqNDdIMOz6F1P0kOYHIrexvm+++gWpNUH+xByUwTROybfqZdPMY1hyF1yGHG
	ZORHHU2taWnq7f82PXcghMHR8ZvXoCz77heuqLWU+cykfnI8wClj49aEvKb/ZAOyrT8BUm6tqP6
	9V38+qEFEbPPPaAkbaSt1JuGEwz5lMBokIlkYuzZ6hM/GjMxVVxN8e3i7s6kp8/gKu0LJtW2ZuK
	K5KFVcdtSDY020xRa8+MLP1vMZcDhcs+TJqqd/dFp7mlxuZ6flAdjR1W+HdAn+voBelPSrIUiVj
	7FqqzFR9tkm+Y6Bjs8o3gEjP3R7omoeVJxNc5CpQMsJ+fZ4t88Mzy6wyy8Pesw9cYmXy92sJZG5
	ZED7TssvMVr9SCyZUp5RvBp1OhuA/xtM3n0uPlFFlCwSvHpUyLKK3nK0Q2TZQ5RiaY2t9KsebOK
	p9OGqtKfZkL+XQLN6COq946I4DFViYl1LDzym1rMTifp49oIjOQdikply7X6Vx6t2t
X-Received: by 2002:a05:701b:270e:b0:12b:fc21:874d with SMTP id a92af1059eb24-12bfc218ac5mr3524770c88.19.1775502127119;
        Mon, 06 Apr 2026 12:02:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c05a7beffsm6197436c88.15.2026.04.06.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:02:06 -0700 (PDT)
Date: Mon, 6 Apr 2026 12:02:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] input: pc110pad: change PCI check to get rid of
 orphaned no_pci_devices
Message-ID: <adQCShxoHCwfcwlm@google.com>
References: <cf519463-775a-4d43-be38-20742fdad407@gmail.com>
 <20260406172324.GA170281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406172324.GA170281@bhelgaas>

On Mon, Apr 06, 2026 at 12:23:24PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 03, 2026 at 12:17:35AM +0200, Heiner Kallweit wrote:
> > As a prerequisite for removing no_pci_devices(), replace its usage here
> > with an equivalent check for presence of a PCI bus.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  drivers/input/mouse/pc110pad.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
> > index efa58049f..c7a6df210 100644
> > --- a/drivers/input/mouse/pc110pad.c
> > +++ b/drivers/input/mouse/pc110pad.c
> > @@ -91,7 +91,7 @@ static int __init pc110pad_init(void)
> >  {
> >  	int err;
> >  
> > -	if (!no_pci_devices())
> > +	if (pci_find_next_bus(NULL))
> >  		return -ENODEV;
> 
> I'd certainly love to get rid of no_pci_devices(), although using
> pci_find_next_bus() is not really much better.
> 
> I don't have much opinion about pc110pad.c change.  It's essentially
> still the same kludge, which has been there at least since the
> beginning of git history.
> 
> Dmitry, if you want to ack this, I can take both together.

Given "x86/cpu: Remove M486/M486SX/ELAN support" I'd just drop the
driver completely.

I tried it in 2024 but Maciej was insistent that keeping these old
drivers doe snot hurt. Now I think we can get rid of them.

You can grab the patch removing it from
https://lore.kernel.org/all/20240808172733.1194442-4-dmitry.torokhov@gmail.com/
as I think it should still apply.

Thanks.

-- 
Dmitry
