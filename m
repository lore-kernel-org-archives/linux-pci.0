Return-Path: <SRS0=rCEc=H3=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=rCEc=H3=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH] PCI/AER: add pcie TLP header information in the
 tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <20180402154708.5032-1-thomas.tai@oracle.com>
 <20180507222136.GD161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180508090756.57f38d17@gandalf.local.home>
 <a5578a08-2434-af48-7910-6f858e5477d6@oracle.com>
 <20180508093459.092988b6@gandalf.local.home>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <24ef86b8-20d9-d654-2af5-159659a9eb76@oracle.com>
Date: Tue, 8 May 2018 09:35:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180508093459.092988b6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 2018-05-08 09:34 AM, Steven Rostedt wrote:
> On Tue, 8 May 2018 09:25:01 -0400
> Thomas Tai <thomas.tai@oracle.com> wrote:
> 
>>>>>    	TP_STRUCT__entry(
>>>>>    		__string(	dev_name,	dev_name	)
>>>>>    		__field(	u32,		status		)
>>>>>    		__field(	u8,		severity	)
>>>>> +		__field(	u32, 		tlp_header_valid)
>>>
>>> I'm guessing tlp_header_valid is just a boolean. It's after severity
>>> which is just one byte long. Why not make this one byte as well,
>>> otherwise you are wasting 3 bytes.
>>
>> Thanks Steven. Yes boolean is fine.
> 
> But don't use "bool", use u8, as bool can be various sizes on different
> archs.

Sure thing. Thank you.

> 
> -- Steve
> 
