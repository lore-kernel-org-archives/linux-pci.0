Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE839A045
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687888; cv=none; b=LyjDLDehdtSxU3XdD59slnEtK26cgP4C4wKrjV/0aoaAeIGmA560MrvWRtKjDaUrdb86IzDmEYyw3mrusU00Khtd7fO5xzbK8arPN3O+R3ujMyovItTic141PmbnLZLVobP5BXWs2b699T/gHPUwwRghiz2MH6Qdq0BMlS13tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687888; c=relaxed/simple;
	bh=Ch7JlFp085OS098b7/18gFzyAYM+A9X2+LIkHQ7YpIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUOyO21RQOZ/2sRECpIjdAdu4sAeyrr+U6WLZJFFxitN+VjYsNDLv9i3/CBEgN7vz+wPFHHafKqqOR1rWwaOsvffmK+Gv4ZvpFvS97lwPbZHUGP+KVPqtP4E638mQYmL15/iQX/NnK/IWlwA1E24ECD9/f7mZ+Xe+Wy7Ugc0k/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T4praowv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T4praowv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfbfdabf3fso250668885a.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776687885; x=1777292685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch7JlFp085OS098b7/18gFzyAYM+A9X2+LIkHQ7YpIE=;
        b=T4praowvx//dA8hjJk9l6l/pZwl6yibxcOtmQqPPJcOKlLKGMIBUxn4QsdGpDrTXlm
         1arwMtkVht67P7ZWe76BQk3BlfNxt/sLeCIYQpPrRUzK97Xi3Z3Oj/sikeytDNozOHC+
         V0Qj6YLhOrRycPoOumYIfCzjoyGtzPCCdFs+LV3KS0vjFQWY9daqdf9yxUGUpSp7b+z5
         cV2ClG2RIApv3jZmaWDsda8z5LK1IDR4FDpKMoPEA5X/oNdUrIRsHqFrrEbzL5vv7FkI
         7bu5YzQWqevdb549KGgPeKWWIInnx03unyVqThoy5238l/MfXGlhxSXQOsvsf6INYOEP
         96mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776687885; x=1777292685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch7JlFp085OS098b7/18gFzyAYM+A9X2+LIkHQ7YpIE=;
        b=lohzln+cnDhgbfCKhaz9zJsjCm8w9isl/u4e3qZKhTmNh4SpDQgQAX57r+PVtJ1zVG
         XyGpnlmcxelwuq9T9iq+jxX4nkUZf8ZfS03XHmKfGQpP5JXomvoHF4GqRGxsYWtTl1Ge
         Ne9Jf2zl53ps0+5Yh+YWqt7hidS8lcktdRUFji7o2mNhrkQWhxq0vJCcxOfT6MFy443I
         A6NXEouxjnqHN5ykTUPInxihlz6DpW/PAzwotYhNz/Xvj/rjy+fJMR0OFzJpp8TvtAfp
         W/muhyC7E+/OTHHNVGg7sB39s8X85lxWjyrn98dCBNUYV3qZd/Si7xGSo+ucsfGmYO7C
         /qzA==
X-Forwarded-Encrypted: i=1; AFNElJ8+KCpQox9K0zMxRxvUVGxewNHVcsbRXoO+v8BE6OSgOujDcLUfX8qleFugA7uiB+aOUfj5hRYLi6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMIg2Ytd9QRPlTkKq9sRmfnxVqrMNrA5YTr2p7WzUJhDkWmvC
	wAOF5sP9fkOy2eJk7iAUvnL6wI2FK68LgIuSH5e83r+MG6yWGtzv/aNsnx/5cADcFb4JheWZIPi
	zMI9w8II=
X-Gm-Gg: AeBDiestLcDNo+RyqwmHRC1dmLiwT/bS0vLIWW/5rUDeJHwG4DyhnsQbU1sxbdjhJ8N
	rzHcLDO1SeXUGWa+RoQaAbe1MAFjfIx3DyGYrttrXvPgqUxk6m1p7G2Xn5xJNYzlJJuQdhCa3f6
	2c8f/qU2cd/eCiAlRhWQuoC3tt/7rE/b5h6rWv8RIL6U2qdoZ1elTa6Mh85NqxGXFeKoyAjLPMS
	aQXEk8VWFpqe1AS6gtGHq34lKxMienA5KxEponKAiOhtjYM7lbHWvP+pRGdD1kxCTQakv3+1Va3
	wftL4A+avNna8+vpS8jsDkh0g/2P05C4IqPz0eobuOR0FIA68/yXyQCZBW1aOwI8OVpWMTAZyZZ
	RACD1LZYIMZQyaWT2XyheU9FcQyWJTxaJdDsnStD+wRVIguy+5ViSViuI/Lx6DePQLWUy/UDYg/
	O8WqJzz784QPDYDbzis5uvdnxJ+7NHhH1ddW7s8jcPkPqb3spYNCH+KCsvIgBqAysp+UrsOxJFw
	YZZe+NFZD83AUaME8j1Oav7Azs=
X-Received: by 2002:a05:620a:440b:b0:8cb:3e7c:a4a4 with SMTP id af79cd13be357-8e79208250dmr1865255685a.46.1776687885418;
        Mon, 20 Apr 2026 05:24:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc72dsm169155785a.34.2026.04.20.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:24:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wEngC-0000000CEWE-0Joa;
	Mon, 20 Apr 2026 09:24:44 -0300
Date: Mon, 20 Apr 2026 09:24:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nazar Mokrynskyi <nazar@mokrynskyi.com>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com,
	linux-pci@vger.kernel.org
Subject: Re: vfio/pci: Qualcomm PCIe WiFi devices drop link during FLR
 causing host AER crash
Message-ID: <20260420122444.GN2577880@ziepe.ca>
References: <70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com>

On Sat, Apr 18, 2026 at 12:24:07AM +0300, Nazar Mokrynskyi wrote:
> Several Qualcomm PCIe WiFi devices drop their PCIe link as part of their
> internal reset sequence. Under bare metal this is transparent because the
> host root complex performs link retraining automatically. Under VFIO
> passthrough, the link-drop generates an uncorrectable AER error that
> escalates through the parent bridge to the host, crashing it.

If AER's crash the system then it is not compatible with VFIO, IMHO.

For VFIO to work as designed the platform must be able to safely
contain all the errors the PCI device can generate.

Jason
