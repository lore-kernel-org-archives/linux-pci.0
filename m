Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:44810 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbbCFQjf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 11:39:35 -0500
MIME-Version: 1.0
In-Reply-To: <54F9BCDC.5000500@mm-sol.com>
References: <1424367708-17149-1-git-send-email-matwey@sai.msu.ru> <54F9BCDC.5000500@mm-sol.com>
From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date: Fri, 6 Mar 2015 19:39:13 +0300
Message-ID: <CAJs94Ea5W7A2ZYR55GPe2vPm2HiUScx+zYm8VwXMvLssrwdJCQ@mail.gmail.com>
Subject: Re: [PATCH v3] pci: spear: Drop __initdata from spear13xx_pcie_driver
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-03-06 17:42 GMT+03:00 Stanimir Varbanov <svarbanov@mm-sol.com>:
> On 02/19/2015 07:41 PM, Matwey V. Kornilov wrote:
>> spear13xx_pcie_driver.driver is allocated in text.init section
>> and then the pointer to it is passed futher. This patch is to avoid
>> crashes like the following, when freed memory is used.
>>
>
> What happened with this patch, could it go as a fix?
>

With this patch the kernel works as expected (without crashes), I
think it could be considered as a fix.



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
