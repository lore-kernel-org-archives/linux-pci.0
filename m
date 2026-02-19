Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE9337BBB
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523115; cv=none; b=EO4KG99bXP26IBxEPMgsfAlc4Vm22vL5C1naacoZI/F5wVnhynf1Zd3HAOT04BJPYDwqS3/Jm8bQOWrK8dKZLcUqDKbBuhR0wIMR0gCEWgdBmIfxSpoIMq060nCkJtDJagW7jL9LXPMfLmKvvlsoOJNMoX1MufxxKH8Vs3RBtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523115; c=relaxed/simple;
	bh=t4deFB51LnQ53AFsy/xfWYZchzKH3oME5ZiZ+RzQWLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VI5Pd6sU7IQsz92xrrAkvCZfOTpSeBbN/2Xw0KrkRLKqWPLGwm13/3c67wSNK1oY/PF3otS1/eAK44h1V3kpVa+w9Ox33Ax5elVthHl+HBF5jSJhwCPs5UfQZ9iq6MqkcbKk/jGhJy+g9noNbl9EO4zQWX3VqWjq+8syQWhxNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca8528Z1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca8528Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33C0C2BC9E
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771523115;
	bh=t4deFB51LnQ53AFsy/xfWYZchzKH3oME5ZiZ+RzQWLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ca8528Z13MtQYDwZIV/4PfyeZOv8JCxcPOXsBX4EMgFE2O08uQgygE9NVFEJ01KWf
	 3pCwDXABMG3JwlnzNmqFgkfRcrDMqXb+1XuDwH+hHz+G0ZGVu+kUQIGL9tI4ImtaMj
	 GnmC+NxyuQoAiIt6p+yY9bJKAOXBoQsI6cxCD1zdeer1qc2uZKSp/RGWjRqPbhkgxk
	 km/WGIcLznMmjstm+igtOGMAi5dYR9ztjRfb7DgvF8NnnvkfRBD5KYdNrCs+CNiSt6
	 wiq7KIgn/14xOg5Vicy4IbhWmoR+abFy61opPDVJGQ/m72A8n8g9wDsVKdCQp2MYZN
	 TpvlVobv+rvQQ==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79801df2524so11353987b3.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 09:45:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEnZ4P0Mp0tmPCBSUpQGY9ix5yXPZbopdmSwowF7CRmnk4Kv0WNba1AuB5DX7pjmZVBEqWGsFC/yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbnYqITN4fAzsW1naciiTrBBeZMVQbAuPbp87mTEDYUVr81A7
	iyGkDMxUtEwAiKzl9sv1Ymk62tt27ywnM89pd+ErdZB6F5u+YJYA4aiAPJ3xwiLwviWNbrXC0pK
	UWuAVmRPFH7qzuip6iB9nUWO3oTif6mY=
X-Received: by 2002:a05:690c:b:b0:794:ff4d:9201 with SMTP id
 00721157ae682-7979e899694mr199251967b3.35.1771523114969; Thu, 19 Feb 2026
 09:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com> <20260218-wakeirq_support-v7-2-0d4689830207@oss.qualcomm.com>
In-Reply-To: <20260218-wakeirq_support-v7-2-0d4689830207@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 18:45:04 +0100
X-Gmail-Original-Message-ID: <CAD++jLmP_H4tegm2TkVy0TCDELomxORyEgHY41csBBXEWe5H=g@mail.gmail.com>
X-Gm-Features: AaiRm53hLGf1TLPgfB2vDs0s89u28dwO0xov-JW_O2PRLaGFVNVTVn4ICQasA1g
Message-ID: <CAD++jLmP_H4tegm2TkVy0TCDELomxORyEgHY41csBBXEWe5H=g@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] gpio: Add fwnode_gpiod_get() helper
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com, 
	driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 9:12=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:

> Add fwnode_gpiod_get() as a convenience wrapper around
> fwnode_gpiod_get_index() for the common case where only the
> first GPIO is required.
>
> This mirrors existing gpiod_get() and devm_gpiod_get() helpers
> and avoids open-coding index 0 at call sites.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Looks helpful.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
