Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92073A4517;
	Fri, 20 Mar 2026 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005375; cv=none; b=K+vYwNn3ZP6QZTOYXii4yoH1fCxrerJrPFizIZ5BwibPQIJ5FL/iZqBEOrkCjmcPuaKLLNkBOvY7N0Tesi9rUn9jtjCJ0l7//eJ7RvW36+mBSUCM9GyR+WJE9+yl/IqQNnWh+NApfUwGfWEjmvdjRnWe/W1+sJ+aYi6bNh5C7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005375; c=relaxed/simple;
	bh=tUluXszkRozVfMsYUbs+pkVKTIwBbvZX3p3JYxGVrfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpdLKarLxGu+8P4zUbZxCVJbTTFVD1ExSOQyJnPopcFXzXwHlbEEiZIn/2dJiTHQqJEg3ZCmBmxJGG4v0sOLtV5kKYB+bZi2pguJj+1I2Trh6zySfJGD9NlsIsBBmkmTPLrT1OYtJvHvZFQ7F1IFH5qjRXQs6jkQw0+qst7gJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syoBq3D0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syoBq3D0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABE6C2BC9E;
	Fri, 20 Mar 2026 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774005374;
	bh=tUluXszkRozVfMsYUbs+pkVKTIwBbvZX3p3JYxGVrfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syoBq3D0KJj0LB7Cv/YxzrtscFMUqnYgmMBa/SAFc/5wYC5HfOuGYDqAdJxP+UpIM
	 C1yZhAN3cicymqBtJxIWTJvDYOmrxfFtc2YCNVmF38ac+xTembdWNS7jSLXEDIiVVg
	 MaLwmAkkE6fodCQqf+CH8eQy6Z/+kAZHWZ8Kd2rjBkswSH+AIA3/W72R01YkyfYN4i
	 rWvP3a9ZZC/eUqCQZr6SXa2hWrL+KFWizvmZ5JfxR04WIbGk68ZJAYrWykedTT0edG
	 hJHpFlbpB6r2JmaaVWoPCPJan92ym0az1Hubpo789F77IdgVY1eSIY82YLO3pLxpUC
	 C+0JAFzejQ0KA==
Date: Fri, 20 Mar 2026 12:16:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange
 mapping test case
Message-ID: <ab0seD_G4ER7R_9N@ryzen>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-3-f1a49534ebea@foss.st.com>
 <abrM0Jvo_sdWSTLc@ryzen>
 <28a71759-1095-4403-b356-d291a828daba@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a71759-1095-4403-b356-d291a828daba@foss.st.com>

On Fri, Mar 20, 2026 at 10:35:20AM +0100, Christian Bruel wrote:
> Hello,
> 
> > > 
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index 55e128ed82f00ae13b6fe9768cdbe56adbe8f9da..34ba06fb53f04e48c1c05f4aae85e6ecd03ef447 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -61,6 +61,7 @@
> > >   #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
> > >   #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
> > >   #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
> > > +#define STATUS_BAR_SUBRANGE_SETUP_NOSPC		BIT(18)
> > >   #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
> > >   #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> > > @@ -476,8 +477,11 @@ static int pci_endpoint_test_bar_subrange_cmd(struct pci_endpoint_test *test,
> > >   		return -ETIMEDOUT;
> > >   	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > > -	if (status & fail_bit)
> > > +	if (status & fail_bit) {
> > > +		if (status & STATUS_BAR_SUBRANGE_SETUP_NOSPC)
> > > +			return -ENOSPC;
> > 
> > Perhaps this should be something like:
> > 
> > if (command == COMMAND_BAR_SUBRANGE_SETUP && status & STATUS_BAR_SUBRANGE_SETUP_SKIP)
> 
> I'm not sure about replacing STATUS_BAR_SUBRANGE_SETUP_NOSPC by
> STATUS_BAR_SUBRANGE_SETUP_SKIP
> 
> The selftest will use if (ret == -ENOSPC), so we need to return this
> information (bellow). and semantically SKIP does not imply ENOPSC (instead
> of the contrary)
> 
> as you prefer,

FWIW, I think an even better solution is to introduce a new register,
named e.g. errno in struct pci_epf_test_reg;

That way, we don't need to take a new bit, e.g.:
+#define STATUS_BAR_SUBRANGE_SETUP_NOSPC          BIT(18)

For every unique error code a command can return.

We would simply return STATUS_BAR_SUBRANGE_CLEAR_FAIL, and then the host
side driver looks at the errno register to see the specific error code.

This way, all other _FAIL commands could also return a more specific error
in case of failure.


> 
> To minimize changes, what about something like:
> 
>  unsigned int fail_bit = status & fail_bits;
> 
>  if (fail_bit == STATUS_BAR_SUBRANGE_SETUP_NOSPC)
>    return -ENOSPC;
> 
>  if (fail_bit == STATUS_BAR_SUBRANGE_SETUP_FAIL)
>    return -EIO;
> 
> called with
> 
>        pci_endpoint_test_bar_subrange_cmd(...,
>        STATUS_BAR_SUBRANGE_SETUP_FAIL | STATUS_BAR_SUBRANGE_SETUP_NOSPC);
> 
> replacing the fail_bit parameter with fail_bits.

Sounds okay to me, but I think the idea of adding an errno register is
more extensible.


Kind regards,
Niklas
