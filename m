Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40909 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbbBQGRk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Feb 2015 01:17:40 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so50025938obc.4
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2015 22:17:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJs94EbeyuZjpMWo2UnYgEVLnj-o2NZu-e_B2bo7bepqxo67Hw@mail.gmail.com>
References: <1423585882-5464-1-git-send-email-matwey@sai.msu.ru>
	<CAKohpoknDBJpDAfAGCGb2V_Uq6j3vL=CYOWLzsEn7p35Bi6oEg@mail.gmail.com>
	<54DB0A52.4090907@mm-sol.com>
	<CAJs94EYS003e_j0S4rzKFEL=PqCqEmT7yd0qdJdnMrziE1700Q@mail.gmail.com>
	<54DB1EAC.3060302@mm-sol.com>
	<CAJs94EYNs9+Ph3EXZLPEepWJxU_ivXp=Tifq=LkJZ3mwk1fG3g@mail.gmail.com>
	<54DD5CAF.9040006@mm-sol.com>
	<CAJs94EbeyuZjpMWo2UnYgEVLnj-o2NZu-e_B2bo7bepqxo67Hw@mail.gmail.com>
Date: Tue, 17 Feb 2015 14:17:39 +0800
Message-ID: <CAKohpom__a8PCRbnv_5vRAphzpH7PVBZ+R-Pa5G-eWDDUZncdg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] pci: spear: Use platform_driver_probe instead of platform_driver_register
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mohit KUMAR <mohit.kumar@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15 February 2015 at 21:16, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> Or maybe it doesn't work at all.

It wouldn't have as that wasn't required earlier. But when we are fixing it, we
fix it proper.
