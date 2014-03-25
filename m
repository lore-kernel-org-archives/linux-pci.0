Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:41163 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbaCYARm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Mar 2014 20:17:42 -0400
Received: by mail-ig0-f175.google.com with SMTP id ur14so9349726igb.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2014 17:17:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <83f00436a12b44f799bd1222b91297cd@DM2PR05MB671.namprd05.prod.outlook.com>
References: <CAA93t1rPE3yUh8nAGJDiqeGhixznZdhdyFwRoX_c1VWT3WEtvw@mail.gmail.com>
	<1395699232-28727-1-git-send-email-yinghai@kernel.org>
	<83f00436a12b44f799bd1222b91297cd@DM2PR05MB671.namprd05.prod.outlook.com>
Date: Mon, 24 Mar 2014 17:17:41 -0700
Message-ID: <CAE9FiQXuv4tW44_9sRUyx7NxgGaw4hxVm7DJCYugX33K-ZrVcg@mail.gmail.com>
Subject: Re: [PATCH v2] pciehp: only wait command complete for real hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Rajat Jain <rajatjain@juniper.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 24, 2014 at 4:19 PM, Rajat Jain <rajatjain@juniper.net> wrote:
> Just a note  :-)
>
>> -v2: use second way that is suggested by Bjorn.
>>     It also solve the problem on Rajat's sytem that have wrong inital CC
>
> Er, not wrong initial CC.
>
> Just a different (but not necessarily wrong) different CC bit behavior :-). In my systems, the CC bit gets set for every write to the slot control register (even if Button, LED, EMI, power controller are not implemented).
>
>> Tested-by: Rajat Jain <rajatxjain@gmail.com>
>
> Yes, I tested and it seems to work fine on such systems too.

Thanks for inputs for change log changes.

Assume Bjorn will sort it out.

Thanks

Yinghai
