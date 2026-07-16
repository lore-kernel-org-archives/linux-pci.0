Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6390439907
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221760; cv=none; b=KAxwfmQP4DTEu6nCPkiZu7JOhevPnbVZCQ5To5fvzo6zp+dN51LNtVr680YH1E0KKfTb5cdvq8DLfuNKt19PV2zd2Ze56ayblL+yV+OUeYdsMY5t0cvG52IqmxuAsJc5bM1mk+netIE9NWYU5oYm6TRXSlINDjasRwBfSVwcZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221760; c=relaxed/simple;
	bh=tEPuH0w8ovN1LWEjJQMK9Q1Z1vEJ7za/094ayvYh7Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o86MAncaKNflpoekq6a7YyM9blmKL4iHhpduk0A1oqbhtowNapt/IBxx3EHKBqX+P6OFHbzBYqZzOUq2qxw+hYozXxg39tmEKw2SjTMvnVveNqE/0/A4JPx93LnlcC7xOFyUsQxGzb6MlPYtu10H0yOe/0MQ1sgB1vFiIUPjFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYTW+WUn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYTW+WUn"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e6f2ee60bso6128107b3.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784221756; x=1784826556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=519dNdxGkZChACNROtarKLrXjiSKkCZfa7q39zzxKTI=;
        b=VYTW+WUnV6p8qiFJOifCb9/rtzXQwOuU5/ykei7O9j4/sYZZfN1TBH+58wQ7taT/ux
         1DSuGUPIALJflMoNbhzyGxXMDeylrpeqxxiou+P7pVQ5AFHWv2sTotifo/3OP5H5ACTp
         xjQNDlNDDcD9NMCkxXUpg9a6QV87Ckp8SOeI47UHVOJqiH5miavUWKlco22GNmTftTTo
         OcNwVJsg36QtkHghjxW/s6CUckaW2NyXhBqbPFSc4+tnYnANtzLB0E9mbdMscVGcJeNK
         Uz6bnb0Sr9DBTSyh4ZmiI+4/DCN4yjGjGE7HbQfW883t8VTUqEvdN0iyv6oOr3kZFRgg
         xjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784221756; x=1784826556;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=519dNdxGkZChACNROtarKLrXjiSKkCZfa7q39zzxKTI=;
        b=HuGi9UbLt71rCni8dnrosl2q2BVPuWtr25enpiaamCmvagIvM85eTcsfdrx7ut6XUR
         K3b9sg0LDvTz/NH/DgpJBfjl7f6O1G4X0sLA1u8N4+2p9Jx/3di+c3sdj361oOasMGug
         B1bo/P/5HsrlqhVa0KlF8NrpIea1TEwiKuDTL2Hd6kKAk1Thbz2nYzzd/NmsFO7EcDwQ
         fzQH2cTNyZgmlaoy1jYZYwtm/FoyzoiQBQXmu76ITcMap9C8hkF0Iv2c9EcrH0KuCiul
         5gxr8y/5DLRrmdCwPYqPBlvhfDE+jLZNshCUxceUr11jGnvPhq2ZqlNEV6Xv06vrbDe2
         7aVg==
X-Forwarded-Encrypted: i=1; AHgh+RqrYlZtqs/Zhh/sVsu2v84Cd6Go0CLplhcNZdbIPhIvd5IeFY22+JVyCXqb9jeBTbG7GlUwpZRCQP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFS/4VvNtgIkkVtblbK4IqmS6K4GbHFChBwsfOvR4TF5rFJN9
	FJOE5fuxh9MYoL+W4wRCaoUXwCtB0joXNQwPObvz3yywm/dAMl3p7Crc
X-Gm-Gg: AfdE7ckfyYmX8ZP6sENdgwa+KthQIEutd4UJVBhCQpHTHgraufK0lD+EzoiPEWSgxVN
	MPrGeMgN4xo7lUaBAjccHjCwXGQqVsy4lheVtTyefj5yRUADY2DKzx50WZPipx1Vyv4k+saRKQp
	/cbjQd+G3bm8Fcu4+JcHYubqUMNI/cWVV8nWob8RFTgQ3OqKRXuq6lQDWpPoJKOhF4KTwbWZ6pU
	3FXaPYnQDpak5nsFJbLY8V2qgafsdfEuPL2dLVqHhAv1NGJ9Vzo/4EjjpG3RkX+GHL2LsnKMQda
	BnC3hHqKBuF+lQ8kAgKTnLIPSL4wowM+rYoINqBsBrU2KkCi59Z7BsPtlZge0HTK/pA/KSG4nWX
	J1K9w5Mx06CRjN7xjzX4m6SMryZPpfoJ0Fhp2gofOhpsbSoyvGai12gvY0jS74PGAYjVAmW+6c1
	cFNRGfodQiPstaF4LECyqh+QThSObI/lx7bbQCVJL0icw/cTjoncWPqhnWSbt8h0gWA5t2tg==
X-Received: by 2002:a05:690c:6983:b0:81e:429f:24ba with SMTP id 00721157ae682-81ee298087bmr22881717b3.36.1784221756342;
        Thu, 16 Jul 2026 10:09:16 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c249b87sm199484877b3.49.2026.07.16.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:09:15 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:09:08 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "leonardo.costa@toradex.com" <leonardo.costa@toradex.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, Sherry Sun <sherry.sun@nxp.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Message-ID: <i6x6wpua7wlwmdq3hitoo53wkptgp62tvegmkabcru3d54eqg3@yk4eehwaarn2>
References: <20260629143439.361560-1-leoreis.costa@gmail.com>
 <20260715234736.GA288957@bhelgaas>
 <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>

On Thu, Jul 16, 2026 at 02:15:42AM +0000, Hongxing Zhu (OSS) wrote:
> Hi Leonardo,
> 
> Would you be able to test this patch on your affected boards? Your testing
> would help expedite the merge process and ensure the fix resolves the boot
> issue you're experiencing.
> 
> Best Regards
> Richard Zhu

Hi Richard,

Sorry for taking long to respond, I was caught up with something. I
tested the patch and it solved the issue. I sent a Tested-by tag there.
Thanks for looking into this!

Best Regards
Leonardo
