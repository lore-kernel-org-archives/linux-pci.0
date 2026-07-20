Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD342CB1E;
	Mon, 20 Jul 2026 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584793; cv=none; b=JDyd3w3KmurwM5PWWM6itfOe8lbAgOdWg47lHqI52YFWc+FvGQdHu0csyrq7F87kph9nehHLau812XL3IYFJPiGH+anUqCwNrtSFwKhgnnRuG7LixH3MXIWyp2f2mVd5KWbrrgSL7qMFXRKWqrsw+vbZpPKGoKgrVr2zgj3HY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584793; c=relaxed/simple;
	bh=D0ckuBsCZ74OC823vK3qxIRyTeNiJP9v8oSt51s2Hgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiN3FpWWnOSCqcWrwKQRpEqkxQEqPE4IDnm4+/gUzxfvzB72bAj9/mDQxyXL44QJw4zv9Jos/295gEral48j8/X4NIkq7FI069+MsoZLdXQFKkMdgfef8+Ys8ku/euvYXNuIUq/QOhSaVe5jnoRfwYCMP3kqIRdSh1Um1KUMjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HovYPW6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HovYPW6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BDE1F000E9;
	Mon, 20 Jul 2026 21:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784584792;
	bh=a6WrH1AIy+EK4Fw2+FOXO+vq75HdWci5vwL+qT5Ta4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HovYPW6fiGWU66tFqNtu10vR52vWnoSaRI54L1LrC4I0aVd0QRg+vUmQ6KiDtwjvZ
	 TO0PAWlZsD7CMYmkyByMojv4kkBywjFyKfnIFf6XjlHTQL3slD56ml8qapzjClmrYB
	 YzG2nKCgab0hIvV9d/PMc1TW867aJRarEZvrWwC5lFJzXZ7JxejAoRn+vBYRzT70lW
	 9OegIrsEsQVmSHl/qYhSIrqpBfs0u9tKN4DQsAHY/BpMukSI5G59QOS13hx3b8KcvK
	 buuADXN5TGdAsb0lWmfcBDqebyBB+EegeKhn8uQTzYZNR/Uox5nVmN9jCI2nimSKmQ
	 kfmWnzUy9zPQg==
Date: Mon, 20 Jul 2026 22:59:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 03/13] cxl: Tighten CPER kfifo registration API and
 symbol visibility
Message-ID: <20260720225943.0415d43c@jic23-huawei>
In-Reply-To: <20260717222706.3540281-4-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-4-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:26:56 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>
> 
Hi Terry, Dan,

There are a few different things in here. Having them all together
may make it a little harder to keep track of the different changes.

> Tighten the CPER protocol error kfifo registration API and symbol
> visibility.
> 
> Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_NS_GPL() for
> the CPER kfifo registration symbols. This names the consuming module
> explicitly and gives compile-time enforcement.
To me this is one patch.
> 
> Drop the work_struct argument from the unregister path. Change the
> WARN_ONCE condition to a NULL check since there is no caller pointer
> to compare against anymore.

This is one.

> 
> Change register/unregister return types to void. Flag double registration
> with WARN_ONCE() inside the lock instead of returning an error.
Another change.

That covers why for the register, for unregister maybe mention it was
unchecked anyway.

> 
> Change cxl_ras_init() to void because there is one consumer and one producer
> so the error return was unnecessary. Remove the now-dead error check in
> cxl_core_init().
This is change

> 
> Add a diagnostic log when the driver is not bound in
> cxl_cper_handle_prot_err().
Unrelated really to all the rest. 

All nice changes and maybe a few of them can be combined but to me this
is too many in one.  Anyhow I might be letting perfect be enemy of
good and all that so if others think it should go in as one then
I'm fine with that.

Trivial thing inline todo with formatting consistency.

> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> 
> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/acpi/apei/ghes.c | 32 +++++++++++++++-----------------
>  drivers/cxl/core/core.h  |  7 ++-----
>  drivers/cxl/core/port.c  |  6 +-----
>  drivers/cxl/core/ras.c   | 12 +++++++-----
>  include/cxl/event.h      | 17 ++++++-----------
>  5 files changed, 31 insertions(+), 43 deletions(-)
> 
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index ff97fea718d2c..3471d4f75c025 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -287,10 +287,10 @@ struct cxl_cper_prot_err_work_data {

> -static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
> +static inline void cxl_cper_register_prot_err_work(struct work_struct *work)
>  {
> -	return 0;
>  }

I'd go a bit long and move { } up.  Compact stubs are always nice!


> -static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +static inline void cxl_cper_unregister_prot_err_work(void)

This one is shorter than the one you did it for above!

>  {
> -	return 0;
>  }
>  static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
>  {

