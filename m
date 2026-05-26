Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C80421880
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819723; cv=pass; b=bY7JuQqdwsaWVXrwLpJU8HI33qNmup89l538ApeHYxzKk0hlO+B24tVGm5a7ayXpWh5E+20wYgC704oktz9iuGPsMYGM3vXe049U0ypCuZWyCgxYjkHGQoXLhqWK3uQJeUHRQalPQOMBil4HOOfThU0/40k6ZRJ0d9yNWO7EJc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819723; c=relaxed/simple;
	bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYdzsPYX9PJMMsrWmMfWcH/jrzrZm2Dh1pl+DkbY0O7wIHl80Tleptp+L7nGwFRXuaS8WmFvQL6/qEB6J6WjCxLLMnT171DBYq/YTb5+yvt8YzpZo+knAaTYBf7DkRAxaMzALllvuo11KYQsWQpv5EJaFJ+Wx0rzty3F2AuvKx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlXrT3lW; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlXrT3lW"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3047a628b34so228859eec.3
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 11:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779819719; cv=none;
        d=google.com; s=arc-20240605;
        b=cdCOCEUwxzbK08Apz7l9yB4snlt9c6FbjVSsHa2UbjAVo+peK3k5G9QRcnvIADzzrH
         d8ALWWWWQKlGlU5sUdN9Fy+xpmqxrmBU38fE7+TubwVPlu2wIzzywB3bPCUFG8QzEXGH
         EUOHSWE1YCNbLDSzrwgwpRjd81zdaTlrW54JZkQA367HpC//xMAM40UtiZKF7nkS34UI
         eccO9+oAzBtf4DKgfSphAGQpFF6GvJ4CN23y44mbaDN0/iXi6r0jNZ6Be3CqGWJyOY63
         oHm9OAI4gvH7LTdXWXWpKhcBdHSmjxTfbmqtIdXTHvS1YTJIYeQz7u09mQi2qCitWZjl
         QpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        fh=KnW3NZknr+inhkRZGvb0gQiGzcsiNFAeebyN1T3kIRI=;
        b=GRcyaBuPke450AbQRydtzKsW3775nECHZaVs7TXJrzt8LSg+UPuy56Cfo76B078Oaj
         tx9QhNKobNFGabE9R9dY0syq9sYbNXI2NrPdusOCWvxWzCcgWwTeiyvAbZ+SQGtkAlry
         nj7w45rNQl63WLVrWyeg2/zusys0JLCfjrK6qvxkkqU/riQY48SEw88rEHk7c/hlgF/y
         bNQZP8aeTM9RvMQveYWs/2SzUKJrGYskPDNsGrYoLRvG7YixVqLTIuGOa3zT/CY2u+Sx
         ckOeo2Qn1tiEqb4slR3byrKatEVNdAsPgO8Y3ohWgvTIFSqy3yddHk/MJW3FEiu9tGMh
         8gmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779819719; x=1780424519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        b=qlXrT3lWn7CREfHFK9zMeIZFg0kNvix1PpPz9wUMf+cvc2WDwVU0o4MscpxyJZhsGI
         CwXWZ/zyfXOhEd55gNKMGYb1D6RsPL5KQCZ8ZPTolJcNjHcvsCeR/O0ha9c4quLkTHBp
         9a1881kAzfVfGOoLWAv/H1W7QLffXVCpSuc+KeweCYGVMxhYtGMys6zfzis06qTG7lgh
         q7IJs5llE5+fvdiKNtaVooKmVgF2yaUjVRdYtljW1wmVs4FAjMBJed3TUB3bpB3Tpl+7
         J4O28IKYG47fna6IZj6UJ8i/pJH4mQHEAvWcbe6pTRn3yFCJi07wFqJsve15L+6ZnUv1
         9C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779819719; x=1780424519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        b=NhabRoSCxV1YV7XgN1kS8+6AcnQZBfQSy9TWFpB2hEm1WtDwKXQZX5lnxWOCYanSLa
         W7go78e9Q2i50JT2LAQTPBX3psaHlGxViIbgkNpznr93IHEhBoVRSlzSVMGm2uKHpceV
         cigZLjf2Hrt33QJz4njqmkk0K2Jv5Ds84+b0IPBU9MlEJF+VqUSY3djkyHIHV9aVXt5k
         82UYyuxzfIycL9/msmT5V46mc0x+qq/QW9689wTNF4yaDZb0ONS2rM7Pmi+eB2HAe4j/
         YYj+BNia6wIzra3UHTrxYsOrZ3E//j2JrpEyx4vRj7b2HC5fSTwQWhUqE22Azb3Rb/Jp
         zJ8A==
X-Forwarded-Encrypted: i=1; AFNElJ+dYNX+Mc+lB0OQ3lV3BGAXyp9YOpzHUo7jPQ5bAhUhhBNtwr8Q4n4TOH5ciFkgxowiC1mdx2WynQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzFPov/Wf53SVAClFkgGq11FVCp0km0r841v+XhCsWe6PiYLt
	0YsbgubZpG/EK57mHiipcw02Rv6FUFBQgkhjGpqV8dlh6f7xsxnY226O6NTq2PKjd/emzCBht1k
	ncPtSsjHB7A78hUiCZD8gCD9qgmhtv9Y=
X-Gm-Gg: Acq92OFEAVyopclM/KpHxqDEk2nBk4NHXO9x0GIZad3JXgcx88QTL7Gffy1Gcp/CLww
	VGhuo/cvKnMuJFP4U7ahbOvMoZApT5rd3hzkbep35UBvpWcui5J1X9YIgVHFRMJpsYC04GbURY3
	o3LmMFuskh24z8Te+25K+PapPAboVIOyuD1bHFs+EtsMsKrR/6F6tcBuQ43hqOdf2MOKNMBaH3F
	psixMbcQaWFyPrZdTzl8LiFSQmFn5pRhaOxcbe7hU/HzOQPXD084owARV5LmRsjfoCiUgjNHjfT
	xOc8Iov/SE7U5Jea65h7WfABNkx6fC9VGcMeDsZR8ri5fKT1qtkqYe9LvYuHrXeQj2QsI472m9/
	NXQ0YRF/tnCqHtwaPBcp4qVc=
X-Received: by 2002:a05:7301:2b06:b0:304:2af3:5fef with SMTP id
 5a478bee46e88-3044921564fmr4123223eec.8.1779819719412; Tue, 26 May 2026
 11:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525202921.124698-1-dakr@kernel.org> <20260525202921.124698-3-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-3-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 20:21:47 +0200
X-Gm-Features: AVHnY4LERaGUubmcoHWuZ6pDVh-Er4DRAsv1wa0D_Oc3ExDNDH2ULqOUOsIQmwA
Message-ID: <CANiq72mNqdOmQ3Va=EF-Fg+-BXW=O=px4z4+YQTS6wzL87=ZHQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/24] rust: alloc: remove `'static` bound on `ForeignOwnable`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com, 
	ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 10:29=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> The `'static` bound is currently necessary because there's no
> restriction on the lifetime of the GAT. Add a `Self: 'a` bound to
> restrict possible lifetimes on `Borrowed` and `BorrowedMut`, and lift
> the `'static` requirement.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
