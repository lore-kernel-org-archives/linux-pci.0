Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKsTQnkBPEiUtpaVxyDm--BLnHvUCtVMhEUQ5-FQryp-X9HBUg@mail.gmail.com>
References: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
	<CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
	<CAKsTQn=u5HuMCz5_L1jbx6Fvz5Rf_e14tNeEPwxy1o8dxk4J8g@mail.gmail.com>
	<CAE9FiQWxiLV0YeWfUAd=vJaxtV-0PrqBqm1ptKnFoEM0jQDaiQ@mail.gmail.com>
	<CAKsTQn=skDo7mbTrvFfQHW+nD1Ggy-g+qT922WOrjiwqyK5BwQ@mail.gmail.com>
	<CAKsTQn=aigrfTz5hYmzvERK3w6Ax1yxEyZfzWt_NaT6d+-DYuA@mail.gmail.com>
	<CAE9FiQWxBWaJh0CbbEfeBUJK+54NDrTW6r0v-6itXEyTkmzkhQ@mail.gmail.com>
	<CAKsTQnkBPEiUtpaVxyDm--BLnHvUCtVMhEUQ5-FQryp-X9HBUg@mail.gmail.com>
Date: Tue, 29 Sep 2015 08:36:18 -0700
Message-ID: <CAE9FiQVfPwkg-EX2B1bYS+KD2_atN-xSh-EAXtGh0GqZxcftKQ@mail.gmail.com>
Subject: Re: PCIe bus (re-)numbering
From: Yinghai Lu <yinghai@kernel.org>
To: Ruud <netwerkforens@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 29, 2015 at 7:04 AM, Ruud <netwerkforens@gmail.com> wrote:
>
> (for illustration, lspci -tv from a 3.2 kernel, hand edited as the
> original picture has already discovered the subordinate busses)
>             +-02.0-[04-17]----00.0-[05-17]--+-04.0-[06-16]----00.0-[07-16]---
>              |                               |
>       \-08.0-[11-16]----
>

please try to post lspci -tv and whole boot log.

Yinghai
