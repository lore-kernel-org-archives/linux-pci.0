Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40232 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaB0W5i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 17:57:38 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so3088530obb.4
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2014 14:57:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5JzL-9T-Hn=fp1S9=URzycpKTy6toaA0AjQfJYt7mQXsA@mail.gmail.com>
References: <CAHH3p5JzL-9T-Hn=fp1S9=URzycpKTy6toaA0AjQfJYt7mQXsA@mail.gmail.com>
Date: Thu, 27 Feb 2014 14:57:37 -0800
Message-ID: <CAE9FiQXP9WZWiaiCJoq846UwdjOfGSM74me29Oue3RHKwxpGCg@mail.gmail.com>
Subject: Re: PCIE: Program pcie device private registers
From: Yinghai Lu <yinghai@kernel.org>
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 27, 2014 at 1:12 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> We can program config space registers of a pcie device using setpci but how
> can we program private registers of a pcie device?

What do you mean private registers?

Are those registers in MMIO range that is set through pci BAR?

Thanks

Yinghai
