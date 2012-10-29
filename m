Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45674 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab2J2NLD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 09:11:03 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so5187444vcb.19
        for <linux-pci@vger.kernel.org>; Mon, 29 Oct 2012 06:11:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <adb41404ceb2e4e4baa6adfe7df0bfec6c42813f.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
	<adb41404ceb2e4e4baa6adfe7df0bfec6c42813f.1351492562.git.pratyush.anand@st.com>
Date: Mon, 29 Oct 2012 18:41:02 +0530
Message-ID: <CAOh2x=kdMX6erZEXmxtQA24rHZ4BUodtgtURYOAxLTM4011tPg@mail.gmail.com>
Subject: Re: [PATCH 06/15] clk: SPEAr1310: Fix pcie clock name
From: viresh kumar <viresh.kumar@linaro.org>
To: Pratyush Anand <pratyush.anand@st.com>
Cc: arnd@arndb.de, shiraz.hashim@st.com, spear-devel@list.st.com,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	olof@lixom.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 29, 2012 at 12:31 PM, Pratyush Anand <pratyush.anand@st.com> wrote:
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> ---
>  drivers/clk/spear/spear1310_clock.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

It is not required, that you send one patch per file. If two changes to two
files are having the same purpose, then merge them.

Merge this with 5/15.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
